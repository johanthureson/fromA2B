//
//  TripResultsScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation

@Observable
class TripResultsScreenViewModel {
    
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
