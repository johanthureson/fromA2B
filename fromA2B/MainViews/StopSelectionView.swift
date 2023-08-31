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
    
    var busStopTextFieldString: String = ""
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""
    
    init(busStopName: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "") {
        self.busStopTextFieldString = busStopName
        self.stops = stops
        self.errorMessage = errorMessage
    }
    
    func fetchStops() async {
        await MainActor.run {
            errorMessage = ""
        }
        if let res = await NetworkAPI.shared.getStops(busStopName: busStopTextFieldString) {
            await MainActor.run {
                stops = res
            }
        } else {
            await MainActor.run {
                errorMessage = "Fetch data failed"
            }
        }
    }
}

struct StopSelectionView: View {
    
    enum FocusField: Hashable {
      case field
    }

    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedStopLocation: StopLocation?
    @State fileprivate var model: StopSelectionViewModel
    
    
    init(stops: [StopLocationOrCoordLocation]? = nil, selectedStopLocation: Binding<StopLocation?>) {
        _model = State(initialValue: StopSelectionViewModel(stops: stops))
        _selectedStopLocation = selectedStopLocation
    }

    var body: some View {
        
        VStack {
            
            Button("Back to Main") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .accessibility(identifier: "back_button")
            
            TextField("Bus stop name", text: $model.busStopTextFieldString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .focused($focusedField, equals: .field)
                .onAppear {
                    self.focusedField = .field
                }
                .onSubmit {
                    Task {
                        await model.fetchStops()
                    }
                }
            
            Button("Search") {
                Task {
                    await model.fetchStops()
                }
            }
            .padding()

            List {
                ForEach(model.stops ?? []) { stopLocationOrCoordLocation in
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
    StopSelectionView(
        stops: StopResponse.originStopResponse?.stopLocationOrCoordLocation,
        selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation)
    )
}
