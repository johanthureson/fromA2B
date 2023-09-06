//
//  fromA2BwatchAppApp.swift
//  fromA2BwatchApp Watch App
//
//  Created by Johan Thureson on 2023-08-30.
//

import SwiftUI

@main
struct fromA2BwatchApp_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentScreen()
        }
        .modelContainer(for: FromToModel.self)
    }
}
