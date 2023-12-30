//
//  TripSearchScreenView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation
import SwiftData

@Observable
fileprivate class TripSearchScreenViewModel {
    var fromString = String(localized: "stopButtonView.from")
    var toString = String(localized: "stopButtonView.to")
}

struct TripSearchScreenView: View {
    @Environment(\.appModel) private var appModel
    private var viewModel = TripSearchScreenViewModel()
    @Query var fromToModels: [FromToModel]

    var body: some View {
        
        @Bindable var bindableAppModel = appModel

        NavigationStack {
            
            StopChoiceButtonView(directionText: viewModel.fromString,
                                 selectedStopLocation: $bindableAppModel.fromStopLocation)
            .accessibility(identifier: "from_button")
            
            StopChoiceButtonView(directionText: viewModel.toString,
                                 selectedStopLocation: $bindableAppModel.toStopLocation)
            .accessibility(identifier: "to_button")

            NavigationLink("Search") {
                getTripResultsScreenView(bindableAppModel: bindableAppModel)
            }
            .disabled(appModel.fromStopLocation == nil || appModel.toStopLocation == nil)
            .padding()
            
            savedTripSearches()
        }
    }
    
    // New trip search
    
    private func getTripResultsScreenView(bindableAppModel: AppModel) -> some View {
        appModel.fromStopLocation = bindableAppModel.fromStopLocation
        appModel.toStopLocation = bindableAppModel.toStopLocation
        let tripResultsScreenViewModel = TripResultsScreenViewModel(
            fromStopLocation: bindableAppModel.fromStopLocation,
            toStopLocation: bindableAppModel.toStopLocation)
        return TripResultsScreenView(viewModel: tripResultsScreenViewModel)
    }
    
    // Saved trip searches
    
    private func savedTripSearches() -> some View {
        List {
            ForEach(fromToModels) { fromToModel in
                NavigationLink(getFromToString(fromToModel: fromToModel)) {
                    getTripResultsScreenView(fromToModel: fromToModel)
                }
            }
        }
    }

    private func getFromToString(fromToModel: FromToModel) -> String {
        let from = fromToModel.fromStopLocation?.name ?? "from"
        let to = fromToModel.toStopLocation?.name ?? "to"
        return from + "\n -> \n" + to
    }

    private func getTripResultsScreenView(fromToModel: FromToModel) -> some View {
        let tripResultsScreenViewModel = TripResultsScreenViewModel(
            fromStopLocation: fromToModel.fromStopLocation,
            toStopLocation: fromToModel.toStopLocation)
        return TripResultsScreenView(viewModel: tripResultsScreenViewModel)
    }
}

#if DEBUG
#Preview {
    TripSearchScreenView()
        .environment(\.appModel,
                      AppModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
#endif
