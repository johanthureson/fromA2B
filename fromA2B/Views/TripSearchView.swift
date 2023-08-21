//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

@Observable final class TripSearchViewModel {
    
    var from = String(localized: "stopButtonView.from")
    var to = String(localized: "stopButtonView.to")
    var showingFromSheet = false
    var showingToSheet = false
}

struct TripSearchView: View {

    @State private var viewModel = TripSearchViewModel()
    @Environment(\.tripSearchModel) private var tripSearchModel

    var body: some View {
        
        @Bindable var bindableTripSearchModel = tripSearchModel

        NavigationStack {
            
            Button {
                viewModel.showingFromSheet.toggle()
            } label: {
                HStack {
                    Text(viewModel.from)
                        .foregroundColor(.black)
                    Text(tripSearchModel.fromStopLocation?.name ?? "<>")
                }
            }
            .padding()
            .sheet(isPresented: $viewModel.showingFromSheet) {
                StopSelectionView(selectedStopLocation: $bindableTripSearchModel.fromStopLocation)
            }
            
            Button {
                viewModel.showingToSheet.toggle()
            } label: {
                HStack {
                    Text(viewModel.to)
                        .foregroundColor(.black)
                    Text(tripSearchModel.toStopLocation?.name ?? "<>")
                }
            }
            .padding()
            .sheet(isPresented: $viewModel.showingToSheet) {
                StopSelectionView(selectedStopLocation: $bindableTripSearchModel.toStopLocation)
            }

            NavigationLink("Search") {
                getTripResultsView(bindableTripSearchModel: bindableTripSearchModel)
            }
            .disabled(tripSearchModel.fromStopLocation == nil || tripSearchModel.toStopLocation == nil)
            .padding()
            
        }
    }
    
    private func getTripResultsView(bindableTripSearchModel: TripSearchModel) -> some View {
        tripSearchModel.fromStopLocation = bindableTripSearchModel.fromStopLocation
        tripSearchModel.toStopLocation = bindableTripSearchModel.toStopLocation
        let tripResultsViewModel = TripResultsViewModel(fromStopLocation: bindableTripSearchModel.fromStopLocation, toStopLocation: bindableTripSearchModel.toStopLocation)
        return TripResultsView(viewModel: tripResultsViewModel)
    }
    
}

#Preview {
    TripSearchView()
}
