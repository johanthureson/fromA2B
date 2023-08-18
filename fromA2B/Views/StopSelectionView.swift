//
//  StopSelectionView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation

struct StopSelectionView: View {
    
    enum FocusField: Hashable {
      case field
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedStopLocation: StopLocation?
    @State private var bustStopName: String = ""
    @State private var stops: [StopLocationOrCoordLocation]?
    @State private var errorMessage = ""
    @FocusState private var focusedField: FocusField?
    
    init(selectedStopLocation: Binding<StopLocation?>) {
        _selectedStopLocation = selectedStopLocation
    }

    var body: some View {
        
        VStack {
            
            Button("Back to Main") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            
            TextField("Bus stop name", text: $bustStopName)
                .textFieldStyle(.roundedBorder)
                .padding()
                .focused($focusedField, equals: .field)
                .onAppear {
                    self.focusedField = .field
                }
            
            Button("Search") {
                Task {
                    await fetchStops()
                }
            }
            .padding()

            List {
                ForEach(stops ?? []) { stopLocationOrCoordLocation in
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
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getStops(busStopName: bustStopName) {
            await MainActor.run {
                self.stops = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }

}

#Preview {
    StopSelectionView(selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
