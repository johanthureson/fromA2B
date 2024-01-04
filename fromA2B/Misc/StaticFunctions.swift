//
//  StaticFunctions.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-01.
//

import Foundation

struct StaticFunctions {
    
    /*
     According to this article:
     https://nshipster.com/secrets/
     "Client Secrecy is Impossible",
     so I will leave this key in the open.
     Setting up a server to host the key is not the scope of this project.
     But would be recommended otherwise.
     The worst that can happen is that someone uses my quota.
     But easier for that person would be to get a free key of their own here:
     https://www.trafiklab.se/api/trafiklab-apis/resrobot-v21/
     */
    static func getApiKey() -> String? {
        return "8036e1f4-06df-47e6-8477-f76939124550"
    }
    
}
