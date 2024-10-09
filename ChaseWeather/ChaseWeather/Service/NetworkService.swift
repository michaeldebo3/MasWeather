//
//  NewtworkService.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct NetworkService: NetworkServiceable {

    ///  Returns the `WeatherData` object for a given location's name.
    ///
    /// - Parameters:
    ///   - city: Name of icon returned from [API]
    /// - Returns: Background image name
    ///
    /// [API]: https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    func fetchData(city: String) async throws -> WeatherData? {
        let formattedCity = city.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCity)&appid=d2ba2173027054ab4e64886bc1a7ffb0")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherData.self, from: data)
    }
    
    ///  Returns the image that is used as WeatherDisplay's icon image.
    ///
    /// - Parameters:
    ///   - iconCode: Returned from `fetchData`
    /// - Returns: Icon image
    ///
    /// [API]: https://openweathermap.org/img/wn/{iconCode}@2x.png
    func fetchIcon(iconCode: String) async throws -> UIImage? {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
    
    ///  Returns the name of the location given a location's coordinates..
    ///
    /// - Parameters:
    ///   - `lat`: user location's latitude returned from [API]
    ///   - `long`: user location's longitude returned from [API]
    /// - Returns: Location name
    ///
    /// [API]: http://api.openweathermap.org/geo/1.0/reverse?lat={lat}&lon={long}&limit=2&appid={API key}
    func fetchNameFromLocation(lat: Double, long: Double) async throws -> String {
        let url = URL(string: "http://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(long)&limit=2&appid=985189ad0a7a2871c8f0d832c4f424c1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let results = try JSONDecoder().decode([ReverseGeocoding].self, from: data)
        return results.first?.name ?? ""
    }
}

