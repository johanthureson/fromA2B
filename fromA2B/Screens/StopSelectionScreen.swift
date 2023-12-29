//
//  StopSelectionScreen.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

@Observable
fileprivate class StopSelectionScreenModel {
    
    var isLoading = false
    private let requestManager = RequestManager()

    var busStopTextFieldString: String = ""
    var stops: [StopLocationOrCoordLocation]?
    var errorMessage = ""
    
    init(busStopName: String = "", stops: [StopLocationOrCoordLocation]? = nil, errorMessage: String = "") {
        self.busStopTextFieldString = busStopName
        self.stops = stops
        self.errorMessage = errorMessage
    }
    
    func fetchStops() async {
        
        errorMessage = ""
        isLoading = true
/*
 vad kan gå fel?
 borde jag lägga in RequestManagerProtocol,
 så jag kan skapa vyn med mock
 och inspektera?
 fast jag gör ju ui-tester inför merge till master
 */
        do {
            let stopRespons: StopResponse = try await requestManager.perform(
                StopsRequest.getStops(
                    busStopName: busStopTextFieldString))
            
            stops = stopRespons.stopLocationOrCoordLocation
            
            await stopLoading()
            
        } catch {
            await stopLoading()
            errorMessage = "Fetch data failed"
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }

}

struct StopSelectionScreen: View {
    
    enum FocusField: Hashable {
      case field
    }

    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedStopLocation: StopLocation?
    @State fileprivate var model: StopSelectionScreenModel
    
    
    init(stops: [StopLocationOrCoordLocation]? = nil, selectedStopLocation: Binding<StopLocation?>) {
        _model = State(initialValue: StopSelectionScreenModel(stops: stops))
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
                .disableAutocorrection(true)
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
            .accessibility(identifier: "search_button")

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
        .overlay {
            if model.isLoading {
                ProgressView("Finding Stops near you...")
            }
        }
    }
}

#if DEBUG
#Preview {
    StopSelectionScreen(
        stops: StopResponse.originStopResponse?.stopLocationOrCoordLocation,
        selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation)
    )
}
#endif
