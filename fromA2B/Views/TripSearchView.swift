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
}

struct TripSearchView: View {

    private var viewModel = TripSearchViewModel()
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
                getTripResultsView(bindableTripSearchModel: bindableTripSearchModel)
            }
            .disabled(tripSearchModel.fromStopLocation == nil || tripSearchModel.toStopLocation == nil)
            .padding()
            
        }
    }
    
    private func getTripResultsView(bindableTripSearchModel: TripSearchModel) -> some View {
        tripSearchModel.fromStopLocation = bindableTripSearchModel.fromStopLocation
        tripSearchModel.toStopLocation = bindableTripSearchModel.toStopLocation
        return TripResultsView(fromStopLocation: tripSearchModel.fromStopLocation, toStopLocation: tripSearchModel.toStopLocation)
    }
    
}

#Preview {
    TripSearchView()
}
