//
//  TripSearchView.swift
//  fromA2BwatchApp Watch App
//
//  Created by Johan Thureson on 2023-08-30.
//

import SwiftUI
import Observation
//import SwiftData

@Observable
fileprivate class TripSearchViewModel {
    
    var from = String(localized: "stopButtonView.from")
    var to = String(localized: "stopButtonView.to")
}

struct TripSearchView: View {

//    @Environment(\.appModel) private var appModel
    @State private var model = TripSearchViewModel()
    @Query var fromToModels: [FromToModel]

    var body: some View {
        
//        @Bindable var bindableAppModel = appModel

        NavigationStack {
            /*
            StopChoiceButtonView(directionText: model.from,
                                 selectedStopLocation: $bindableAppModel.fromStopLocation)
            .accessibility(identifier: "from_button")
            
            StopChoiceButtonView(directionText: model.to,
                                 selectedStopLocation: $bindableAppModel.toStopLocation)
            .accessibility(identifier: "to_button")

            NavigationLink("Search") {
                getTripResultsView(bindableAppModel: bindableAppModel)
            }
            .disabled(appModel.fromStopLocation == nil || appModel.toStopLocation == nil)
            .padding()
            */
            Text("A")
            List {
                ForEach(fromToModels) { fromToModel in
                    Text(fromToModel.fromStopLocation?.name ?? "hej")
//                    NavigationLink(getFromToString(fromToModel: fromToModel)) {
//                        getTripResultsView(fromToModel: fromToModel)
//                    }
                }
            }
        }
    }
    /*
    private func getTripResultsView(bindableAppModel: AppModel) -> some View {
        appModel.fromStopLocation = bindableAppModel.fromStopLocation
        appModel.toStopLocation = bindableAppModel.toStopLocation
        let tripResultsViewModel = TripResultsViewModel(
            fromStopLocation: bindableAppModel.fromStopLocation,
            toStopLocation: bindableAppModel.toStopLocation)
        return TripResultsView(model: tripResultsViewModel)
    }
    
    private func getTripResultsView(fromToModel: FromToModel) -> some View {
        let tripResultsViewModel = TripResultsViewModel(
            fromStopLocation: fromToModel.fromStopLocation,
            toStopLocation: fromToModel.toStopLocation)
        return TripResultsView(model: tripResultsViewModel)
    }
    */
    /*
    private func getFromToString(fromToModel: FromToModel) -> String {
        let from = fromToModel.fromStopLocation?.name ?? "from"
        let to = fromToModel.toStopLocation?.name ?? "to"
        return from + "\n -> \n" + to
    }
    */

}
/*
#Preview {
    TripSearchView()
        .environment(\.appModel,
                      AppModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
*/
