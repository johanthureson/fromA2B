//
//  TripResultsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
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
    
    @State var model: TripResultsViewModel
    
    init(model: TripResultsViewModel) {
        self.model = model
    }

    var body: some View {
        VStack(spacing: 16) {
            if model.errorMessage != "" {
                Text(model.errorMessage)
            }
            List {
                ForEach(model.trips) { trip in
                    
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
                if !model.preview {
                    await model.fetchTrips()
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
    TripResultsView(model: TripResultsViewModel(preview: true, trips: TripResponse.tripResponse!.trip!))
}
