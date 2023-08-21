//
//  AppModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import Foundation
import SwiftUI

@Observable
public class TripSearchModel {
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    
    init(fromStopLocation: StopLocation? = nil, toStopLocation: StopLocation? = nil) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
    }
}

@Observable class StopLocationModel: Identifiable {
    let id = UUID()
    var stopLocation: StopLocation
    
    init(stopLocation: StopLocation) {
        self.stopLocation = stopLocation
    }
}

extension EnvironmentValues {
    var tripSearchModel: TripSearchModel {
        get { self[TripSearchModelKey.self] }
        set { self[TripSearchModelKey.self] = newValue }
    }
}

private struct TripSearchModelKey: EnvironmentKey {
    static var defaultValue: TripSearchModel = TripSearchModel()
}
