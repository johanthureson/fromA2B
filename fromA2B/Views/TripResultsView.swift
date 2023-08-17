//
//  TripResultsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

struct TripResultsView: View {
    
    @Environment(\.tripSearchModel) private var tripSearchModel

    var body: some View {
        
        NavigationStack {
            
            List {
            
                ForEach(TripResponse.tripResponse?.trip ?? []) { trip in
                    
                    NavigationLink(destination: TripDetailsView(trip: trip)) {
                        VStack {
                            fromToText(trip: trip)
                                .padding()
                                .font(.title2)
                            
                            ForEach(trip.legList?.leg ?? []) { leg in
                                fromToText(leg: leg)
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
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
    TripResultsView()
}
