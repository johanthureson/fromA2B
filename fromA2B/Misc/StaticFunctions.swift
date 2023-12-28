//
//  StaticFunctions.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation
import KeychainSwift

struct StaticFunctions {

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
    
    static func getApiKey() -> String? {
        let keychain = KeychainSwift()
        let apiKey = keychain.get("ResRobotAccessId")
        return apiKey
    }
    
}

