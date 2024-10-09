//
//  WeatherOverview.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

struct WeatherOverview: Codable, Equatable {
    /// Shown on WeatherDisplay view.
    let summary: String
    /// Used to fetch the icon and to indicate which background image to show.
    let iconCode: String
}

extension WeatherOverview {
    enum CodingKeys: String, CodingKey {
        case iconCode = "icon"
        case summary = "description"
    }
}
