//
//  StopModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-03.
//

import Foundation
import SwiftData

@Model
class StopModel: Equatable {
    var stopLocation: StopLocation?
    var changedDate: Date?
    
    init(fromStopLocation: StopLocation? = nil, stopLocation: StopLocation? = nil) {
        self.stopLocation = stopLocation
        self.changedDate = Date()
    }
    
    static func == (lhs: StopModel, rhs: StopModel) -> Bool {
        lhs.stopLocation == rhs.stopLocation
    }
}
