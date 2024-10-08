//
//  DaylightDetails.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

struct DaylightDetails: Codable, Equatable {
    let sunriseInUNIXTimestamp: Int
    let sunsetInUNIXTimestamp: Int
}

extension DaylightDetails {
    enum CodingKeys: String, CodingKey {
        case sunriseInUNIXTimestamp = "sunrise"
        case sunsetInUNIXTimestamp = "sunset"
    }
}
