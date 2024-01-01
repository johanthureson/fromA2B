//
//  StopSelectionScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation

@Observable
class StopSelectionScreenViewModel {
    
    init(busStopName: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "") {
        self.busStopTextFieldString = busStopName
        self.stops = stops
        self.errorMessage = errorMessage
    }
    
    var busStopTextFieldString: String = ""
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""

    var isLoading = false
    private let requestManager = RequestManager()
    
    func fetchStops() async {
        
        errorMessage = ""
        isLoading = true
/*
 vad kan gå fel?
 borde jag lägga in RequestManagerProtocol,
 så jag kan skapa vyn med mock
 och inspektera?
 fast jag gör ju ui-tester inför merge till master
 */
        do {
            let stopRespons: StopResponse = try await requestManager.perform(
                StopsRequest.getStops(
                    busStopName: busStopTextFieldString))
            
            stops = stopRespons.stopLocationOrCoordLocation
            
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

