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
#if DEBUG && TEST
        // Tests won't compile otherwise
        return nil
#else
        let keychain = KeychainSwift()
        keychain.set("661da78d-bf7c-4b44-8f33-c02ebc44228a", forKey: "ResRobotAccessId")
        let apiKey = keychain.get("ResRobotAccessId")
        return apiKey
#endif
    }
    
}

