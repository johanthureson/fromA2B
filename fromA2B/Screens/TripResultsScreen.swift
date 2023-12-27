//
//  TripResultsScreen.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation
import SwiftData



@Observable
class TripResultsScreenModel {
    
    var isLoading = false
    private let requestManager = RequestManager()

    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    var errorMessage = ""
    var trips: [Trip] = []
    
    init(
        fromStopLocation: StopLocation? = nil,
        toStopLocation: StopLocation? = nil,
        trips: [Trip] = [Trip](),
        errorMessage: String = ""
    ) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
        self.trips = trips
        self.errorMessage = errorMessage
    }

    func fetchTrips() async {
        
        errorMessage = ""
        isLoading = true
        
        do {
            let tripResponse: TripResponse = try await requestManager.perform(
                TripsRequest.getTrips(
                    originId: fromStopLocation?.extId,
                    destId: toStopLocation?.extId))
            trips = tripResponse.trip ?? [Trip]()
            
            await stopLoading()
            
        } catch {
            await stopLoading()
            errorMessage = "Fetch data failed"
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }
}

struct TripResultsScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var model: TripResultsScreenModel
    
    @Query var fromToModels: [FromToModel]

    @State var saved = false

    var body: some View {
        VStack(spacing: 16) {
            if model.errorMessage != "" {
                Text(model.errorMessage)
            }
            
            Button {
                let fromToModel = FromToModel(fromStopLocation: model.fromStopLocation,
                                              toStopLocation: model.toStopLocation)
                if !saved {
                    modelContext.insert(fromToModel)
                } else {
                    if fromToModels.contains(fromToModel) {
                        print()
                    }
                    modelContext.delete(fromToModel)
                }
                
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                saved = fromToModels.count >= 0 && fromToModels.contains(fromToModel)
                print()
                
            } label: {
                VStack {
                    if saved {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
            }
            .padding(.top)

            List {
                ForEach(model.trips) { trip in
                    
                    NavigationLink(destination: TripDetailsScreen(trip: trip) ) {
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
                if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil) {
                    await model.fetchTrips()
                }
            }
        }
        .onAppear {
            if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil) {
                saved = fromToModels.count >= 0 && fromToModels.contains(FromToModel(fromStopLocation: model.fromStopLocation, toStopLocation: model.toStopLocation))
            }
        }
        .overlay {
            if model.isLoading {
                ProgressView("Finding Trips near you...")
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
    TripResultsScreen(model: TripResultsScreenModel(trips: TripResponse.tripResponse!.trip!))
}