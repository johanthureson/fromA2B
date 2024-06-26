//
//  TripSearchScreenView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation
import SwiftData

struct TripSearchScreenView: View {
    
    @Environment(\.appModel) private var appModel
    private var viewModel = TripSearchScreenViewModel()
    @Query(sort: \FromToModel.changedDate, order: .reverse)
    var fromToModels: [FromToModel]
    
    var body: some View {
        
        @Bindable var bindableAppModel = appModel
        
        NavigationStack {
            
            fromButton(selectedStopLocation: $bindableAppModel.fromStopLocation)
            
            toButton(selectedStopLocation: $bindableAppModel.toStopLocation)
            
            searchButton(bindableAppModel: bindableAppModel)
            
            tripSearchHistoryList()
            
        }

    }
    
    
    
    // MARK: - body views
    
    private func fromButton(selectedStopLocation: Binding<StopLocation?>) -> some View {
        StopChoiceButtonView(directionText: viewModel.fromString,
                             selectedStopLocation: selectedStopLocation)
        .accessibility(identifier: "from_button")
    }
    
    private func toButton(selectedStopLocation: Binding<StopLocation?>) -> some View {
        StopChoiceButtonView(directionText: viewModel.toString,
                             selectedStopLocation: selectedStopLocation)
        .accessibility(identifier: "to_button")
    }
    
    private func searchButton(bindableAppModel: AppModel) -> some View {
        NavigationLink("Search for trip") {
            newSearchLinkedTripResultsScreenView(bindableAppModel: bindableAppModel)
        }
        .disabled(appModel.fromStopLocation == nil || appModel.toStopLocation == nil)
        .padding()
    }
    
    private func tripSearchHistoryList() -> some View {
        List {
            ForEach(fromToModels) { fromToModel in
                NavigationLink {
                    savedSearchLinkedTripResultsScreenView(fromToModel: fromToModel)
                } label: {
                    Text(viewModel.getFromToString(fromToModel: fromToModel))
                        .borderedCaption()
                }
            }
        }
    }
    
    
    
    // MARK: - linked views

    private func newSearchLinkedTripResultsScreenView(bindableAppModel: AppModel) -> some View {
        appModel.fromStopLocation = bindableAppModel.fromStopLocation
        appModel.toStopLocation = bindableAppModel.toStopLocation
        let tripResultsScreenViewModel = TripResultsScreenViewModel(
            fromStopLocation: bindableAppModel.fromStopLocation,
            toStopLocation: bindableAppModel.toStopLocation,
            fromToModels: fromToModels)
        return TripResultsScreenView(viewModel: tripResultsScreenViewModel)
    }
    
    private func savedSearchLinkedTripResultsScreenView(fromToModel: FromToModel) -> some View {
        let tripResultsScreenViewModel = TripResultsScreenViewModel(
            fromStopLocation: fromToModel.fromStopLocation,
            toStopLocation: fromToModel.toStopLocation,
            fromToModels: fromToModels)
        return TripResultsScreenView(viewModel: tripResultsScreenViewModel)
    }
    
}



// MARK: - Preview

#if DEBUG
#Preview {
    TripSearchScreenView()
        .environment(\.appModel,
                      AppModel(
                        fromStopLocation:
                            StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
#endif
