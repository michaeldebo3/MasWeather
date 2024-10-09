//
//  WeatherOverview.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

struct WeatherOverview: Codable, Equatable {
    /// `summary` is shown on WeatherDisplay view.
    let summary: String
    let iconCode: String
}

extension WeatherOverview {
    enum CodingKeys: String, CodingKey {
        case iconCode = "icon"
        case summary = "description"
    }
}
