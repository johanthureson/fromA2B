//
//  BorderCaption.swift
//  fromA2B
//
//  Created by Johan Thureson on 2024-05-06.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
            )
            .foregroundColor(.black)
    }
    
}
