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
            
            fromToHeader(trip: viewModel.trip)
            
            legsList()

        }
        
    }

    
    
    // MARK: - body views
    
    private func fromToHeader(trip: Trip) -> some View {
        let fromText = trip.origin?.name ?? ""
        let toText = trip.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
            .padding()
            .font(.title2)
    }
    
    private func legsList() -> some View {
        ForEach(viewModel.trip.legList?.leg ?? []) { leg in
            VStack {
                timeToTime(leg: leg)
                Text(leg.product?.first?.name ?? "")
                fromToText(leg: leg)
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

    private func fromToText(leg: Leg) -> some View {
        let fromText = leg.origin?.name ?? ""
        let toText = leg.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }

}



// MARK: - Preview

#if DEBUG
#Preview {
    TripDetailsScreenView(trip: TripResponse.tripResponse!.trip!.first!)
}
#endif
