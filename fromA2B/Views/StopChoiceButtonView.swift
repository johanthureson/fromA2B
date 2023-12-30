//
//  StopChoiceButtonView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-22.
//

import SwiftUI

struct StopChoiceButtonView: View {
    
    @State var showingSheet = false
    var directionText: String = ""
    var selectedStopLocation: Binding<StopLocation?>

    var body: some View {
        
        Button {
            showingSheet.toggle()
        } label: {
            HStack {
                Text(directionText)
                    .foregroundColor(.black)
                Text(selectedStopLocation.wrappedValue?.name ?? "<>")
                    .accessibility(identifier: "stop_name")
            }
        }
        .padding()
        .sheet(isPresented: $showingSheet) {
            StopSelectionScreenView(selectedStopLocation: selectedStopLocation)
        }
    }
}

#if DEBUG
#Preview {
    StopChoiceButtonView(directionText: "From",
                         selectedStopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
#endif
