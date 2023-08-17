//
//  AppModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import Foundation
import SwiftUI

@Observable class AppModel: Identifiable {
    
    
    
}



@Observable
public class TripSearchModel {
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
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
