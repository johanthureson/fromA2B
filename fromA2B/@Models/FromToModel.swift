//
//  FromToModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-30.
//

import Foundation
import SwiftData

@Model
class FromToModel: Equatable {
    var fromStopLocation: StopLocation?
    var toStopLocation: StopLocation?
    var changedDate: Date?
    
    init(fromStopLocation: StopLocation? = nil, toStopLocation: StopLocation? = nil) {
        self.fromStopLocation = fromStopLocation
        self.toStopLocation = toStopLocation
        self.changedDate = Date()
    }
    
    static func == (lhs: FromToModel, rhs: FromToModel) -> Bool {
        lhs.fromStopLocation == rhs.fromStopLocation &&
        lhs.toStopLocation == rhs.toStopLocation
    }
}
