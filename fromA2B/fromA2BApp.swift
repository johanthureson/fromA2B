//
//  fromA2BApp.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
//

import SwiftUI
import SwiftData

@main
struct fromA2BApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
