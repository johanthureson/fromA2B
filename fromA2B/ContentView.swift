//
//  ContentView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            TripSearchView()
                .tabItem {
                    Label("Trip Search", systemImage: "􀊫")
                }

        }
        
    }

}

#Preview {
    ContentView()
}
