//
//  TripDetailsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable private final class ViewModel {
    var title = "Hello, World!"
}

struct TripDetailsView: View {
    
    @State private var viewModel = ViewModel()

    var body: some View {
        
        VStack {
            
            Text(viewModel.title)
            
        }
        
    }
}

#Preview {
    TripDetailsView()
}
