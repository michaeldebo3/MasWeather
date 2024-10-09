//
//  NewworkServiceable.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

/// Allows the app to use a class `NetworkService` that inherits from `NetworkServiceable` while also allowing unit tests to use a class
/// `MockNetworkService` that also inherit from `NetworkServiceable`.
protocol NetworkServiceable {
    func fetchData(city: String) async throws -> WeatherData?
    func fetchIcon(iconCode: String) async throws -> UIImage?
    func fetchNameFromLocation(lat: Double, long: Double) async throws -> String
}
