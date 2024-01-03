//
//  StaticFunctions.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation
import KeychainSwift

struct StaticFunctions {
    
    static func getApiKey() -> String? {
#if DEBUG && TEST
        // Tests won't compile otherwise
        return nil
#else
        let keychain = KeychainSwift()
        let apiKey = keychain.get("ResRobotAccessId")
        return apiKey
#endif
    }
    
}
