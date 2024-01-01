//
//  AppModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

@Observable
public class AppModel {
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    
    init(fromStopLocation: StopLocation? = nil, toStopLocation: StopLocation? = nil) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
    }
}

extension EnvironmentValues {
    var appModel: AppModel {
        get { self[AppModelKey.self] }
        set { self[AppModelKey.self] = newValue }
    }
}

private struct AppModelKey: EnvironmentKey {
    static var defaultValue: AppModel = AppModel()
}
