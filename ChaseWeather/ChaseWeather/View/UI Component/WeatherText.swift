//
//  WeatherText.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

/// `WeatherText` struct produces a Text widget that is stylized to show black text with subtle white background during the day. When it is nighttime, the text is white with a subtle black background. This text coloring and background contrast enhances readability.
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
