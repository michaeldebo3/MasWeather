//
//  Coordinates.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

/// Coordinates associated with WeatherData's results to this [API]
/// [API]: https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
struct Coordinates: Codable, Equatable {
    let lat: Double
    let lon: Double
}
