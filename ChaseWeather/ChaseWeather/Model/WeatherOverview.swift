//
//  WeatherOverview.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

struct WeatherOverview: Codable, Equatable {
    let id: Int
    let overview: String
    let summary: String
    let iconCode: String
}

extension WeatherOverview {
    enum CodingKeys: String, CodingKey {
        case overview = "main"
        case iconCode = "icon"
        case summary = "description"
        case id
    }
}
