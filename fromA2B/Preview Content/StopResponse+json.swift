//
//  StopResponse+json.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation



extension StopResponse {
    
    static var originStopResponse = StaticFunctions.loadJson(StopResponse.self, fileName: "location_origin")
    static var destinationStopResponse = StaticFunctions.loadJson(StopResponse.self, fileName: "location_destination")
    
}



extension TripResponse {
    
    static var tripResponse = StaticFunctions.loadJson(TripResponse.self, fileName: "trip")
    
}
