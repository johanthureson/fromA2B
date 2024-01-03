//
//  TripResultsScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation
import SwiftData
import Foundation

@Observable
class TripResultsScreenViewModel {
    
    var isLoading = false
    private let requestManager = RequestManager()
    let maxNumberOfTripsInHistory = 20

    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    var errorMessage: String?
    var trips: [Trip]
    var fromToModels: [FromToModel]
    
    init(
        fromStopLocation: StopLocation? = nil,
        toStopLocation: StopLocation? = nil,
        trips: [Trip] = [],
        fromToModels: [FromToModel] = [],
        errorMessage: String? = nil
    ) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
        self.trips = trips
        self.fromToModels = fromToModels
        self.errorMessage = errorMessage
    }

    func fetchTrips() async {
        
        errorMessage = nil
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
    
    func updateSearchHistory(modelContext: ModelContext) {
        let fromToModel = FromToModel(fromStopLocation: self.fromStopLocation,
                                      toStopLocation: self.toStopLocation)
        let saved = self.fromToModels.count >= 0 && self.fromToModels.contains(fromToModel)
        if !saved {
            if fromToModels.count >= maxNumberOfTripsInHistory {
                if let oldestModel = fromToModels.last {
                    modelContext.delete(oldestModel)
                }
            }
            modelContext.insert(fromToModel)
        } else {
            if let fromToModelToUpdate = fromToModels.first(where: {$0.fromStopLocation == fromStopLocation && $0.toStopLocation == self.toStopLocation}) {
                fromToModelToUpdate.changedDate = Date()
            }
        }
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }
}
