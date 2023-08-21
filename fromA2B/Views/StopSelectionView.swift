//
//  StopSelectionView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

enum FocusField: Hashable {
  case field
}

@Observable
fileprivate class StopSelectionViewModel {
    
    var bustStopTextFieldString: String = ""
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""
    @FocusState var focusedField: FocusField?
    
    init(bustStopTextFieldString: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "", focusedField: FocusState<FocusField?> = FocusState()) {
        self.bustStopTextFieldString = bustStopTextFieldString
        self.stops = stops
        self.errorMessage = errorMessage
        self.focusedField = focusedField
    }
}

struct StopSelectionView: View {
    

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStopLocation: StopLocation?
    @Bindable fileprivate var viewModel: StopSelectionViewModel
    
    
    init(stops: [StopLocationOrCoordLocation]? = nil, selectedStopLocation: Binding<StopLocation?>) {
        _viewModel = Bindable(StopSelectionViewModel(stops: stops))
        _selectedStopLocation = selectedStopLocation
    }

    var body: some View {
        
        VStack {
            
            Button("Back to Main") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            
            TextField("Bus stop name", text: $viewModel.bustStopTextFieldString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .focused($viewModel.focusedField, equals: .field)
                .onAppear {
//                    self.viewModel.focusedField = .field
                }
                .onSubmit {
                    Task {
                        await fetchStops()
                    }
                }
            
            Button("Search") {
                Task {
                    await fetchStops()
                }
            }
            .padding()

            List {
                ForEach(viewModel.stops ?? []) { stopLocationOrCoordLocation in
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
    
    func fetchStops() async {
        await MainActor.run {
            self.viewModel.errorMessage = ""
        }
        if let res = await NetworkAPI.getStops(busStopName: viewModel.bustStopTextFieldString) {
            await MainActor.run {
                self.viewModel.stops = res
            }
        } else {
            await MainActor.run {
                self.viewModel.errorMessage = "Fetch data failed"
            }
        }
    }

}

#Preview {
    StopSelectionView(
        stops: StopResponse.originStopResponse?.stopLocationOrCoordLocation,
        selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation)
    )
}
