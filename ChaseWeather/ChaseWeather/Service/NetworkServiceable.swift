//
//  NewworkServiceable.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

protocol NetworkServiceable {
    func fetchData(city: String) async throws -> WeatherData?
    func fetchIcon(iconCode: String) async throws -> UIImage?
    func fetchNameFromLocation(lat: Double, long: Double) async throws -> String
}
