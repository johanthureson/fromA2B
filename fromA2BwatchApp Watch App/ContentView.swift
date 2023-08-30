//
//  ContentView.swift
//  fromA2BwatchApp Watch App
//
//  Created by Johan Thureson on 2023-08-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
            TripSearchView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
