//
//  ChaseWeatherTests.swift
//  ChaseWeatherTests
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import Testing
@testable import ChaseWeather
import UIKit
import CoreLocation

struct ChaseWeatherTests {
    
    private let weatherData = WeatherData(
        coord: Coordinates(
            lat: 40.7128,
            lon: -73.935242),
        weather:
            [.init(
                summary: "partly cloudy",
                iconCode: "04n")
            ],
        main:
            WeatherDetails(
                tempInKelvin: 291,
                feelsLikeInKelvin: 291,
                minTempInKelvin: 290,
                maxTempInKelvin: 292,
                humidity: 66),
        visibility: 10000,
        wind: Wind(speed: 8,
                   degrees: 86),
        daylightDetails: DaylightDetails(
            sunriseInUNIXTimestamp: 1727174746,
            sunsetInUNIXTimestamp: 1727218179),
        timezone: -14400,
        id: 65,
        name: "New York",
        code: 200
    )
    
    let newYorkLat = 40.7128
    let newYorkLong = -73.935242

    @Test func testLocationManager() async throws {
        let lm = LocationManager()
        #expect(lm.lastKnownLocation == nil && lm.manager.delegate == nil)
        lm.checkLocationAuthorization()
        #expect(lm.manager.delegate != nil)
        let location = CLLocation(latitude: newYorkLat, longitude: newYorkLong)
        lm.locationManager(lm.manager, didUpdateLocations: [location])
        #expect(lm.lastKnownLocation!.latitude == newYorkLat && lm.lastKnownLocation!.longitude == newYorkLong)
    }
    
    @MainActor @Test func testGetDirectionFromDegrees() {
        let weatherDisplayViewModel = WeatherDisplayViewModel(service: MockNetworkService())
        let resultN = weatherDisplayViewModel.getDirectionFromDegrees(3)
        let resultNE = weatherDisplayViewModel.getDirectionFromDegrees(39)
        let resultE = weatherDisplayViewModel.getDirectionFromDegrees(70)
        let resultSE = weatherDisplayViewModel.getDirectionFromDegrees(140)
        let resultS = weatherDisplayViewModel.getDirectionFromDegrees(175)
        let resultSW = weatherDisplayViewModel.getDirectionFromDegrees(210)
        let resultW = weatherDisplayViewModel.getDirectionFromDegrees(270)
        let resultNW = weatherDisplayViewModel.getDirectionFromDegrees(298)
        
        #expect(resultN == "N" && resultNE == "NE" && resultE == "E" && resultSE == "SE" && resultS == "S" && resultSW == "SW" && resultW == "W" && resultNW == "NW")
    }
    
   @Test func testHomeViewModelHappyPath() async throws {
       let service = MockNetworkService()
       let vm = HomeViewModel(service: service)
       let name = try await vm.fetchLocationName(lat: newYorkLat, long: newYorkLong)
       #expect(name == "New York")
    }
    
    @MainActor @Test func testWeatherDisplayViewModelHappyPath() async throws {
        let service = MockNetworkService()
        let vm = WeatherDisplayViewModel(service: service)
        LAST_CITY_SEARCHED = "New York"
        try await vm.fetchData()
        #expect(vm.weatherData == weatherData && vm.icon == service.iconImage)
     }

}

struct MockNetworkService: NetworkServiceable {
    
    let iconImage = UIImage()
        
    func fetchData(city: String) async throws -> WeatherData? {
        if city == "New York" {
            let weatherData = WeatherData(
                coord: Coordinates(
                    lat: 40.7128,
                    lon: -73.935242),
                weather:
                    [.init(
                        summary: "partly cloudy",
                        iconCode: "04n")
                    ],
                main:
                    WeatherDetails(
                        tempInKelvin: 291,
                        feelsLikeInKelvin: 291,
                        minTempInKelvin: 290,
                        maxTempInKelvin: 292,
                        humidity: 66),
                visibility: 10000,
                wind: Wind(speed: 8,
                           degrees: 86),
                daylightDetails: DaylightDetails(
                    sunriseInUNIXTimestamp: 1727174746,
                    sunsetInUNIXTimestamp: 1727218179),
                timezone: -14400,
                id: 65,
                name: "New York",
                code: 200
            )
            return weatherData
        } else {
            return nil
        }
    }
    
    func fetchIcon(iconCode: String) async -> UIImage? {
        return iconImage
    }
    
    func fetchNameFromLocation(lat: Double, long: Double) async throws -> String {
        return "New York"
    }
    
}
