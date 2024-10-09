//
//  WeatherText.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct WeatherText: View {
    var text: String
    var isDay: Bool
    
    var body: some View {
        Text(text)
            .padding(8)
            .background(isDay ? .white.opacity(0.1): .black.opacity(0.1))
            .foregroundColor(isDay ? .black: .white)
            .cornerRadius(8)
    }
}
