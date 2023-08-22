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
    var stopLocation: Binding<StopLocation?>

    var body: some View {
        
        Button {
            showingSheet.toggle()
        } label: {
            HStack {
                Text(directionText)
                    .foregroundColor(.black)
                Text(stopLocation.wrappedValue?.name ?? "<>")
            }
        }
        .padding()
        .sheet(isPresented: $showingSheet) {
            StopSelectionView(selectedStopLocation: stopLocation)
        }
    }
}

#Preview {
    StopChoiceButtonView(directionText: "From",
                         stopLocation: .constant(StopResponse.originStopResponse?.stopLocationOrCoordLocation?.first?.stopLocation))
}
