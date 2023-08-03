//
//  StopSelectionView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable
public final class StopSelectionViewModel {
    
    public var stopResponse: StopResponse?

    public init(stopResponse: StopResponse? = nil) {
        self.stopResponse = stopResponse
    }
}

struct StopSelectionView: View {
    
    @Bindable private var viewModel = StopSelectionViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStopLocation: StopLocation?
    
    init(selectedStopLocation: Binding<StopLocation?>, viewModel: StopSelectionViewModel = StopSelectionViewModel()) {
        _selectedStopLocation = selectedStopLocation
        self.viewModel = viewModel
    }

    var body: some View {
        
        VStack {
            
            Button("Back to Main") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            
            List {
                ForEach(viewModel.stopResponse?.stopLocationOrCoordLocation ?? []) { stopLocationOrCoordLocation in
                    VStack {
                        Text(stopLocationOrCoordLocation.stopLocation?.name ?? "")
                    }
                    .onTapGesture {
                        self.selectedStopLocation = stopLocationOrCoordLocation.stopLocation
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    StopSelectionView(selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation), viewModel: StopSelectionViewModel(stopResponse: StopResponse.originStopResponse))
}
