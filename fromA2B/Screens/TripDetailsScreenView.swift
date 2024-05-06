//
//  TripDetailsScreenView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

struct TripDetailsScreenView: View {
    
    @State private var viewModel: TripDetailsScreenViewModel
    
    init(trip: Trip) {
        self.viewModel = TripDetailsScreenViewModel(trip: trip)
    }

    var body: some View {
        
        
        VStack {
            
            viewModel.trip.fromToText()
                .padding()
                .font(.title2)
            
            legsList()

        }
        
    }

    
    
    // MARK: - body views
    
    private func legsList() -> some View {
        ForEach(viewModel.trip.legList?.leg ?? []) { leg in
            VStack {
                timeToTime(leg: leg)
                Text(leg.product?.first?.name ?? "")
                leg.fromToText()
            }
            .padding()
        }
        
    }
    

    
    // MARK: - subviews

    private func timeToTime(leg: Leg) -> some View {
        let fromTime = leg.origin?.time?.dropLast(3) ?? ""
        let toTime = leg.destination?.time?.dropLast(3) ?? ""
        return Text(fromTime + "-" + toTime).foregroundColor(.red)
    }

}



// MARK: - Preview

#if DEBUG
#Preview {
    TripDetailsScreenView(trip: TripResponse.tripResponse!.trip!.first!)
}
#endif
