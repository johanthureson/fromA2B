//
//  TripResultsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Alamofire
import Observation

@Observable
class TripResultsViewModel {
    
    var preview = false
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    var errorMessage = ""
    var trips: [Trip] = []
    
    init(
        preview: Bool = false,
        fromStopLocation: StopLocation? = nil,
        toStopLocation: StopLocation? = nil,
        trips: [Trip] = [Trip](),
        errorMessage: String = ""
    ) {
        self.preview = preview
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
        self.trips = trips
        self.errorMessage = errorMessage
    }

    func fetchTrips() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getTrips(
            originId: fromStopLocation?.extId,
            destId: toStopLocation?.extId) {
            await MainActor.run {
                self.trips = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
}

struct TripResultsView: View {
    
    @State var viewModel: TripResultsViewModel
    
    init(viewModel: TripResultsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 16) {
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
            }
            List {
                ForEach(viewModel.trips) { trip in
                    
                    NavigationLink(destination: TripDetailsView(trip: trip) ) {
                        VStack {
                            fromToText(trip: trip)
                                .padding()
                                .font(.title2)
                            
                            ForEach(trip.legList?.leg ?? []) { leg in
                                fromToText(leg: leg)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
        .padding()
        .onAppear {
            Task {
                if !viewModel.preview {
                    await viewModel.fetchTrips()
                }
            }
        }
    }
    
    private func fromToText(trip: Trip) -> some View {
        
        let fromText = trip.origin?.name ?? ""
        let toText = trip.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }
    
    private func fromToText(leg: Leg) -> some View {
        
        let fromText = leg.origin?.name ?? ""
        let toText = leg.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }
}

#Preview {
    TripResultsView(viewModel: TripResultsViewModel(preview: true, trips: TripResponse.tripResponse!.trip!))
}
