//
//  StaticFunctions.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation

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
        if let path = Bundle.main.path(forResource: "Hidden", ofType: "plist") {
            let keys = NSDictionary(contentsOfFile: path)
            return keys?["accessId"] as? String ?? nil
        }
        return nil
    }
    
}

