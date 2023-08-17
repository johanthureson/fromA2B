//
//  NetworkAPI.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-17.
//

import Foundation

class NetworkAPI {
    static func getAppliances() async -> [Appliance]? {
        do {
            let data = try await NetworkManager.shared.get(
                path: "/api/v2/appliances?size=4", parameters: nil
            )
            let result: [Appliance] = try self.parseData(data: data)
            return result
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
