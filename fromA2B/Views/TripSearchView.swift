//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

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
    @State private var showingFromSheet = false
    @State private var showingToSheet = false
    @Environment(\.tripSearchModel) private var tripSearchModel

    var body: some View {
        
        @Bindable var bindableTripSearchModel = tripSearchModel

        NavigationStack {
            
            Button {
                showingFromSheet.toggle()
            } label: {
                HStack {
                    Text(viewModel.from)
                        .foregroundColor(.black)
                    Text(tripSearchModel.fromStopLocation?.name ?? "<>")
                }
            }
            .padding()
            .sheet(isPresented: $showingFromSheet) {
                StopSelectionView(selectedStopLocation: $bindableTripSearchModel.fromStopLocation)
            }
            
            Button {
                showingToSheet.toggle()
            } label: {
                HStack {
                    Text(viewModel.to)
                        .foregroundColor(.black)
                    Text(tripSearchModel.toStopLocation?.name ?? "<>")
                }
            }
            .padding()
            .sheet(isPresented: $showingToSheet) {
                StopSelectionView(selectedStopLocation: $bindableTripSearchModel.toStopLocation)
            }

            NavigationLink("Search") {
                TripResultsView()
            }
            .disabled(tripSearchModel.fromStopLocation == nil || tripSearchModel.toStopLocation == nil)
            .padding()
            
        }
    }
    
}

#Preview {
    TripSearchView(viewModel: TripSearchViewModel(fromStopLocation: StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
