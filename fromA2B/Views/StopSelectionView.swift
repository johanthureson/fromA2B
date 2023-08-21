//
//  StopSelectionView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

@Observable
fileprivate class StopSelectionViewModel {
    
    var bustStopTextFieldString: String = ""
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""
    
    init(bustStopName: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "") {
        self.bustStopTextFieldString = bustStopName
        self.stops = stops
        self.errorMessage = errorMessage
    }
}

struct StopSelectionView: View {
    
    enum FocusField: Hashable {
      case field
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStopLocation: StopLocation?
    @State fileprivate var viewModel: StopSelectionViewModel
    
    @FocusState private var focusedField: FocusField?
    
    init(stops: [StopLocationOrCoordLocation]? = nil, selectedStopLocation: Binding<StopLocation?>) {
        _viewModel = State(initialValue: StopSelectionViewModel(stops: stops))
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
                .focused($focusedField, equals: .field)
                .onAppear {
                    self.focusedField = .field
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
