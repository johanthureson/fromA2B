//
//  TripSearchScreenViewModel.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-01-01.
//

import Observation

@Observable
class TripSearchScreenViewModel {
    var fromString = String(localized: "stopButtonView.from")
    var toString = String(localized: "stopButtonView.to")
    
    func getFromToString(fromToModel: FromToModel) -> String {
        let from = fromToModel.fromStopLocation?.name ?? "from"
        let to = fromToModel.toStopLocation?.name ?? "to"
        return from + "\n -> \n" + to
    }

}
