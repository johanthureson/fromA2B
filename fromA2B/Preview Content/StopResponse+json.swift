//
//  StopResponse+json.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation

extension StopResponse {
    static var originStopResponse = PreviewFunctions.loadJson(StopResponse.self, fileName: "location_origin")
    static var destinationStopResponse = PreviewFunctions.loadJson(StopResponse.self, fileName: "location_destination")
}

extension TripResponse {
    static var tripResponse = PreviewFunctions.loadJson(TripResponse.self, fileName: "trip")
}

struct PreviewFunctions {
    static func loadJson<T: Decodable>(_ type: T.Type, fileName: String) -> T? {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(type, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        } else {
            print()
        }
        return nil
    }
}
