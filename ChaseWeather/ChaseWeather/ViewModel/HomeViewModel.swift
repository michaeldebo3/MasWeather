//
//  HomeViewModel.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//
import SwiftUI

class HomeViewModel: ObservableObject {
    private var service: NetworkServiceable
    
    init(service: NetworkServiceable) {
        self.service = service
    }
    
    func fetchLocationName(lat: Double, long: Double) async throws -> String {
        try await service.fetchNameFromLocation(lat: lat, long: long)
    }
}
