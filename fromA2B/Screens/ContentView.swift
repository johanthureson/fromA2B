//
//  ContentView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
//

import SwiftUI

struct ContentView: View {
    
    @State var appModel = AppModel()

    var body: some View {
        
        TabView {
            
            TripSearchScreenView()
                .tabItem {
                    Label("Trip Search", systemImage: "magnifyingglass")
                }
                .environment(appModel)

        }
        
    }

}
