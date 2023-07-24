//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable private final class ViewModel {
    var title = String(localized: "tripSearchView.helloWorld")
    //"Hello, World!"
}

struct TripSearchView: View {

    @State private var viewModel = ViewModel()
    @State private var count = -1
    
    var body: some View {
        
        VStack {
            
            Text(viewModel.title)
                .padding()
            
            Button {
                count += 1
                viewModel.title = String(localized: "\(count) points")
                // "viewModel update works!"

            } label: {
                Image(systemName: "plus")
            }
            .padding()
            
        }
    }
}

#Preview {
    TripSearchView()
}
