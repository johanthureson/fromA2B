//
//  StopSelectionView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

@Observable
public final class StopSelectionViewModel {
    
    public var stopResponse: StopResponse?

    public init(stopResponse: StopResponse? = nil) {
        self.stopResponse = stopResponse
    }
}

struct StopSelectionView: View {
    
    private var viewModel = StopSelectionViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStopLocation: StopLocation?
    
    init(selectedStopLocation: Binding<StopLocation?>) {
        _selectedStopLocation = selectedStopLocation
    }

    var body: some View {
        
        VStack {
            
            Button("Back to Main") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            
            List {
                ForEach(StopResponse.originStopResponse?.stopLocationOrCoordLocation ?? []) { stopLocationOrCoordLocation in
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
    StopSelectionView(selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
