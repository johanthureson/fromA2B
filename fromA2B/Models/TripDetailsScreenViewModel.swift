//
//  TripDetailsScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation

@Observable
class TripDetailsScreenViewModel {
    
    var trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
}

