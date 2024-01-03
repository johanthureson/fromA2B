//
//  StopSelectionScreenView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

struct StopSelectionScreenView: View {
    
    enum FocusField: Hashable {
      case field
    }

    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedStopLocation: StopLocation?
    @State private var viewModel: StopSelectionScreenViewModel
    
    init(
        busStopTextFieldString: String = "",
        stops: [StopLocationOrCoordLocation]? = nil,
        selectedStopLocation: Binding<StopLocation?>,
        errorMessage: String? = nil
    ) {
        _viewModel = State(initialValue:
                            StopSelectionScreenViewModel(
                                busStopTextFieldString:
                                    busStopTextFieldString,
                                stops: stops,
                                errorMessage: errorMessage
                            )
        )
        _selectedStopLocation = selectedStopLocation
    }
    
    

    var body: some View {
        
        VStack {
            
            backButton()
            
            stopTextField()
            
            searchButton()

            stopSelectionList()
            
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView("Finding stops near you...")
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    
    
    // MARK: - body views
    
    private func backButton() -> some View {
        Button("Back to Main") {
            presentationMode.wrappedValue.dismiss()
        }
        .padding()
        .accessibility(identifier: "back_button")
    }

    private func stopTextField() -> some View {
        TextField("Name of stop", text: $viewModel.busStopTextFieldString)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .padding()
            .focused($focusedField, equals: .field)
            .onAppear {
                self.focusedField = .field
            }
            .onSubmit {
                Task {
                    await viewModel.fetchStops()
                }
            }
    }
    
    private func searchButton() -> some View {
        Button("Search") {
            Task {
                await viewModel.fetchStops()
            }
        }
        .padding()
        .accessibility(identifier: "search_button")
    }
    
    private func stopSelectionList() -> some View {
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



// MARK: - Preview

#if DEBUG

#Preview {
    StopSelectionScreenView(
        busStopTextFieldString: "Logdansplan",
        stops: StopResponse.originStopResponse?.stopLocationOrCoordLocation,
        selectedStopLocation: Binding.constant(nil)
    )
}

#Preview {
        StopSelectionScreenView(
            selectedStopLocation: Binding.constant(nil),
            errorMessage: "Error message"
        )
}

#endif
