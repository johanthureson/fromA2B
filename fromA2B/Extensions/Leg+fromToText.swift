//
//  Leg+fromToText.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-05-06.
//

import SwiftUI

extension Leg {

    func fromToText() -> some View {
        let fromText = self.origin?.name ?? ""
        let toText = self.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
            .borderedCaption()
    }

}
