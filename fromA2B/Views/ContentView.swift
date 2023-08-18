//
//  ContentView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
//

import SwiftUI

struct ContentView: View {
    
    @State var tripSearchModel = TripSearchModel()

    var body: some View {
        
        TabView {
            
            TripSearchView()
                .tabItem {
                    Label("Trip Search", systemImage: "􀊫")
                }
                .environment(tripSearchModel)

        }
        
    }

}

#Preview {
    ContentView()
}
