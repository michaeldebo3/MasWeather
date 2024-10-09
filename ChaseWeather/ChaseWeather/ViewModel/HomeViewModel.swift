//
//  HomeViewModel.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//
import SwiftUI

class HomeViewModel: ObservableObject {
    private var service: NetworkServiceable
    
    /// Dependency injection of NetworkServiceable that allows for implementing Mock service in testing.
    init(service: NetworkServiceable) {
        self.service = service
    }
    
    ///  Returns the name of location given the user's latitude and longitude..
    ///
    /// - Parameters:
    ///   - `lat`: latitude of user
    ///   - `long`: longitude of user
    /// - Returns: Location name
    func fetchLocationName(lat: Double, long: Double) async throws -> String {
        try await service.fetchNameFromLocation(lat: lat, long: long)
    }
}
