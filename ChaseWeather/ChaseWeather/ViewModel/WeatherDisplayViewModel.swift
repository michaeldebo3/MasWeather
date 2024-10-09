//
//  WeatherDisplayViewModel.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

@MainActor class WeatherDisplayViewModel : ObservableObject {
    @Published var icon: UIImage? = nil
    @Published var weatherData: WeatherData? = nil
    private var service: NetworkServiceable
    /// Returns user default value for last city searched.
    var city : String {
        LAST_CITY_SEARCHED
    }
    /// Dependency injection of NetworkServiceable that allows for implementing Mock network service in testing.
    init(service: NetworkServiceable) {
        self.service = service
    }
    
    ///  Returns the name of the asset image that is used as WeatherDisplay's background image.
    ///
    /// - Parameters:
    ///   - name: Icon code returned from [API]
    /// - Returns: Background image name
    ///
    /// [API]: https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    func imageFromIconCode(_ code: String) -> String {
        switch code {
        case "01d":
            return "blueSky"
        case "01n":
            return "clearSkyAtNight"
        case "02d":
            return "fewClouds"
        case "02n":
            return "cloudsAtNight"
        case "03d":
            return "scatteredCloudsDay"
        case "03n":
            return "cloudsAtNight"
        case "04d":
            return "brokenCloudsDay"
        case "04n":
            return "brokenCloudsNight"
        case "09d":
            return "rainDay"
        case "10d":
            return "rainDay"
        case "10n":
            return "rainDay"
        case "11d":
            return "thunderstorm"
        case "11n":
            return "thunderstormAtNight"
        case "13d":
            return "snow"
        case "13n":
            return "snowNight"
        case "50d":
            return "mist"
        case "50n":
            return "mistNight"
        default:
            return "blueSky"
        }
    }
    
    ///  Return the wind direction based on degrees
    ///
    /// - Parameters:
    ///   - degrees: Wind degrees range value
    /// - Returns: The wind direction
    func getDirectionFromDegrees(_ degrees: Int) -> String {
        if degrees > 337 || degrees <= 22 {
            return "N"
        } else if degrees > 22 && degrees <= 68 {
            return "NE"
        } else if degrees > 68 && degrees <= 112 {
            return "E"
        } else if degrees > 112 && degrees <= 158 {
            return "SE"
        } else if degrees > 158 && degrees <= 202 {
            return "S"
        } else if degrees > 202 && degrees <= 248 {
            return "SW"
        } else if degrees > 248 && degrees <= 292 {
            return "W"
        } else if degrees > 292 && degrees <= 337 {
            return "NW"
        }
        return "No direction detected"
    }
    

    ///  Fetches the data from [API] based on city  and updates the state
    ///
    /// [API]:  https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
   @MainActor func fetchData() async throws {
        weatherData = try await service.fetchData(city: city)
        guard let weatherData else { return }
        let iconCodeArray = weatherData.weather.compactMap { $0.iconCode }
        if !iconCodeArray.isEmpty {
            icon = try await service.fetchIcon(iconCode: iconCodeArray.first!)
        }
    }
}
