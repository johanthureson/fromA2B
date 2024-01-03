//
//  StopSelectionScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation

@Observable
class StopSelectionScreenViewModel {
    
    init(busStopTextFieldString: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "") {
        self.busStopTextFieldString = busStopTextFieldString
        self.stops = stops
        self.errorMessage = errorMessage
    }
    
    var busStopTextFieldString: String
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""

    var isLoading = false
    private let requestManager = RequestManager()
    
    func fetchStops() async {
        
        errorMessage = ""
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
            errorMessage = "Fetch data failed"
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }

}

