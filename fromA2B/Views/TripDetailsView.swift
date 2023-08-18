//
//  TripDetailsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

struct TripDetailsView: View {
    
    var trip: Trip

    var body: some View {
        
        
        VStack {
            fromToText(trip: trip)
                .padding()
                .font(.title2)
            
            ForEach(trip.legList?.leg ?? []) { leg in
                
                VStack {
                    timeToTime(leg: leg)
                    fromToText(leg: leg)
                }
                .padding()

            }
        }
        
    }
        
    private func timeToTime(leg: Leg) -> some View {
        
        let fromTime = leg.origin?.time?.dropLast(3) ?? ""
        let toTime = leg.destination?.time?.dropLast(3) ?? ""
        return Text(fromTime + "-" + toTime).foregroundColor(.red)
    }

    private func fromToText(trip: Trip) -> some View {
        
        let fromText = trip.origin?.name ?? ""
        let toText = trip.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }
    
    private func fromToText(leg: Leg) -> some View {
        
        let fromText = leg.origin?.name ?? ""
        let toText = leg.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }

}

#Preview {
    TripDetailsView(trip: TripResponse.tripResponse!.trip!.first!)
}
