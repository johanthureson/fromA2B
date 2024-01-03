//
//  StopSelectionScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation
import SwiftData
import Foundation

@Observable
class StopSelectionScreenViewModel {
    
    init(
        busStopTextFieldString: String = "",
        stops: [StopLocationOrCoordLocation]? = nil,
        errorMessage: String? = nil
    ) {
        self.busStopTextFieldString = busStopTextFieldString
        self.stops = stops
        self.errorMessage = errorMessage
    }
    
    var busStopTextFieldString: String
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage: String?

    var isLoading = false
    private let requestManager = RequestManager()
    let maxNumberOfStopsInHistory = 20
    
    func fetchStops() async {
        
        errorMessage = nil
        isLoading = true
        
        do {
            let stopRespons: StopResponse = try await requestManager.perform(
                StopsRequest.getStops(
                    busStopName: busStopTextFieldString))
            stops = []
            if let aquiredStops = stopRespons.stopLocationOrCoordLocation {
                for stop in aquiredStops {
                    if stop.stopLocation != nil {
                        stops?.append(stop)
                    }
                }
            }
            await stopLoading()
        } catch {
            await stopLoading()
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }
    
    func updateStopHistory(modelContext: ModelContext, stopModels: [StopModel], selectedStopLocation: StopLocation) {
        let stopModel = StopModel(stopLocation: selectedStopLocation)
        let saved = stopModels.count >= 0 && stopModels.contains(stopModel)
        if !saved {
            if stopModels.count >= maxNumberOfStopsInHistory {
                if let oldestStop = stopModels.last {
                    modelContext.delete(oldestStop)
                }
            }
            modelContext.insert(stopModel)
        } else {
            if let stopModelToUpdate = stopModels.first(where: {$0.stopLocation == stopModel.stopLocation}) {
                stopModelToUpdate.changedDate = Date()
            }
        }
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}

