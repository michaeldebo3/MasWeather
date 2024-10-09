//
//  BigButton.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct BigButton: View {
    var text: String
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            HStack {
                Text(text)
            }
            .foregroundColor(.black)
                .padding(.all)
                .background(.yellow)
            .cornerRadius(40)
        }
    }
}
