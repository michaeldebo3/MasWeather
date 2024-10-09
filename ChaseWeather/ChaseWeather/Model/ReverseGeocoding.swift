//
//  ReverseGeocoding.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

/// Returns location name when [API] is hit successfully.
/// [API]: http://api.openweathermap.org/geo/1.0/reverse?lat={lat}&lon={long}&limit=2&appid={API key}
struct ReverseGeocoding: Codable, Equatable {
    let name: String
}
