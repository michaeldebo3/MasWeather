//
//  BigButton.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

/// Button that presents as yellow with black text that triggers the`tapped` closure when button is tapped.
struct BigButton: View {
    var text: String
    var tapped: (() -> Void)
    
    var body: some View {
        Button(action: tapped) {
            Text(text)
            .foregroundColor(.black)
                .padding(.all)
                .background(.yellow)
            .cornerRadius(40)
        }
    }
}
