//
//  TripSearchView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

@Observable
fileprivate class TripSearchViewModel {
    
    var from = String(localized: "stopButtonView.from")
    var to = String(localized: "stopButtonView.to")
}

struct TripSearchView: View {

    @Environment(\.tripSearchModel) private var tripSearchModel
    @State private var viewModel = TripSearchViewModel()

    var body: some View {
        
        @Bindable var bindableTripSearchModel = tripSearchModel

        NavigationStack {
            
            StopChoiceButtonView(directionText: viewModel.from,
                                 stopLocation: $bindableTripSearchModel.fromStopLocation)
            
            StopChoiceButtonView(directionText: viewModel.to,
                                 stopLocation: $bindableTripSearchModel.toStopLocation)

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
        .environment(\.tripSearchModel,
                      TripSearchModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
