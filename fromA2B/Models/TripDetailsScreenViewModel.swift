//
//  TripDetailsScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import SwiftUI

@Observable
class TripDetailsScreenViewModel {
    
    var trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
}

