//
//  TripSearchScreen.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation
import SwiftData

@Observable
fileprivate class TripSearchScreenModel {
    
    var from = String(localized: "stopButtonView.from")
    var to = String(localized: "stopButtonView.to")
}

struct TripSearchScreen: View {

    @Environment(\.appModel) private var appModel
    @State private var model = TripSearchScreenModel()
    @Query var fromToModels: [FromToModel]

    var body: some View {
        
        @Bindable var bindableAppModel = appModel

        NavigationStack {
            
            StopChoiceButtonView(directionText: model.from,
                                 selectedStopLocation: $bindableAppModel.fromStopLocation)
            .accessibility(identifier: "from_button")
            
            StopChoiceButtonView(directionText: model.to,
                                 selectedStopLocation: $bindableAppModel.toStopLocation)
            .accessibility(identifier: "to_button")

            NavigationLink("Search") {
                getTripResultsScreen(bindableAppModel: bindableAppModel)
            }
            .disabled(appModel.fromStopLocation == nil || appModel.toStopLocation == nil)
            .padding()
            
            List {
                ForEach(fromToModels) { fromToModel in
                    NavigationLink(getFromToString(fromToModel: fromToModel)) {
                        getTripResultsScreen(fromToModel: fromToModel)
                    }
                }
            }
        }
    }
    
    // New trip search
    
    private func getTripResultsScreen(bindableAppModel: AppModel) -> some View {
        appModel.fromStopLocation = bindableAppModel.fromStopLocation
        appModel.toStopLocation = bindableAppModel.toStopLocation
        let tripResultsScreenModel = TripResultsScreenModel(
            fromStopLocation: bindableAppModel.fromStopLocation,
            toStopLocation: bindableAppModel.toStopLocation)
        return TripResultsScreen(model: tripResultsScreenModel)
    }
    
    // Saved trip searches
    
    private func getFromToString(fromToModel: FromToModel) -> String {
        let from = fromToModel.fromStopLocation?.name ?? "from"
        let to = fromToModel.toStopLocation?.name ?? "to"
        return from + "\n -> \n" + to
    }

    private func getTripResultsScreen(fromToModel: FromToModel) -> some View {
        let tripResultsScreenModel = TripResultsScreenModel(
            fromStopLocation: fromToModel.fromStopLocation,
            toStopLocation: fromToModel.toStopLocation)
        return TripResultsScreen(model: tripResultsScreenModel)
    }

}

#if DEBUG
#Preview {
    TripSearchScreen()
        .environment(\.appModel,
                      AppModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
#endif
