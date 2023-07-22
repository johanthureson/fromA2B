//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable private final class ViewModel {
    var title = "Hello, World!"
}

struct TripSearchView: View {

    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            
            Text(viewModel.title)
                .padding()
            
            Button {
                viewModel.title = "viewModel update works!"
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
