//
//  StopButtonView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-25.
//

import SwiftUI

enum Direction: String {
    case from = "stopButtonView.from"
    case to = "stopButtonView.to"
}

@Observable private final class ViewModel {
    
    init(direction: Direction, stopLocation: StopLocation? = nil) {
        self.direction = direction
        self.stopLocation = stopLocation
    }
    
    let direction: Direction
    let stopLocation: StopLocation?
}

struct StopButtonView: View {
    
    @State fileprivate var viewModel: ViewModel

    var body: some View {
        
        VStack {
            
            Button {
                

            } label: {
                
                HStack {
                    
                    Text(viewModel.stopLocation?.name ?? "")
                        .padding()
                    
                    Spacer()
                    
                    Text(String(localized: String.LocalizationValue(viewModel.direction.rawValue)))
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    
    StopButtonView(viewModel:
                    ViewModel(direction: .from,
                              stopLocation: StopLocation(
                                name: "Logdansplan (Sundbyberg kn)",
                                extId: "740066612"
                              )))
}

