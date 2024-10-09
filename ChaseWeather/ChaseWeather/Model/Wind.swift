//
//  Wind.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

struct Wind: Codable, Equatable {
    /// In meters per second.
    let speed: Double
    /// 0 degrees is perfectly North.
    let degrees: Int
}

extension Wind {
    var speedInMPH: Double {
        speed / 2.23694
    }
    
    enum CodingKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }
}
