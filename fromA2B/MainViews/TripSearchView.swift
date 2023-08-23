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

    @Environment(\.appModel) private var appModel
    @State private var model = TripSearchViewModel()

    var body: some View {
        
        @Bindable var bindableAppModel = appModel

        NavigationStack {
            
            StopChoiceButtonView(directionText: model.from,
                                 stopLocation: $bindableAppModel.fromStopLocation)
            
            StopChoiceButtonView(directionText: model.to,
                                 stopLocation: $bindableAppModel.toStopLocation)

            NavigationLink("Search") {
                getTripResultsView(bindableAppModel: bindableAppModel)
            }
            .disabled(appModel.fromStopLocation == nil || appModel.toStopLocation == nil)
            .padding()
        }
    }
    
    private func getTripResultsView(bindableAppModel: AppModel) -> some View {
        appModel.fromStopLocation = bindableAppModel.fromStopLocation
        appModel.toStopLocation = bindableAppModel.toStopLocation
        let tripResultsViewModel = TripResultsViewModel(
            fromStopLocation: bindableAppModel.fromStopLocation,
            toStopLocation: bindableAppModel.toStopLocation)
        return TripResultsView(model: tripResultsViewModel)
    }
    
}

#Preview {
    TripSearchView()
        .environment(\.appModel,
                      AppModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
