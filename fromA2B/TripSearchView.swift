//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable final class TripSearchViewModel {
    
    var title = String(localized: "tripSearchView.helloWorld")
    
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    
    init(fromStopLocation: StopLocation? = nil, toStopLocation: StopLocation? = nil) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
    }
    
    var from = String(localized: "stopButtonView.from")
    var to = String(localized: "stopButtonView.to")
}

struct TripSearchView: View {

    @Bindable var viewModel = TripSearchViewModel()
    @State private var showingSheet = false

    var body: some View {
        
        VStack {
            
            Button {
                showingSheet.toggle()
            } label: {
                HStack {
                    Text(viewModel.from)
                    Text(viewModel.fromStopLocation?.name ?? "<>")
                }
            }
            .padding()
            .sheet(isPresented: $showingSheet) {
                StopSelectionView(selectedStopLocation: $viewModel.fromStopLocation, viewModel: StopSelectionViewModel(stopResponse: StopResponse.originStopResponse))
            }
        }
    }
}

#Preview {
    TripSearchView(viewModel: TripSearchViewModel(fromStopLocation: StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
