//
//  NetworkAPI.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-17.
//

import Foundation

class NetworkAPI {

    static func getStops(busStopName: String?, networkManager: NetworkManager = NetworkManager.shared) async -> [StopLocationOrCoordLocation]? {
        do {
            let parameters = [
                "input": busStopName ?? "",
            ]
            let data = try await networkManager.get(
                path: "/location.name?format=json",
                parameters: parameters
            )
            let result: StopResponse = try self.parseData(data: data)
            return result.stopLocationOrCoordLocation
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    static func getTrips(originId: String?, destId: String?) async -> [Trip]? {
        do {
            
            let parameters = [
                "originId": originId ?? "",
                "destId": destId ?? "",
                "passlist": "true",
                "showPassingPoints": "true",
            ]
            
            let data = try await NetworkManager.shared.get(
                path: "/trip?format=json",
                parameters: parameters
            )
            let result: TripResponse = try self.parseData(data: data)
            return result.trip
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}
