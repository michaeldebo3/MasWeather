//
//  LastCitySearched.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

let lastCitySearchedUserDefaultKey = "com.ollify.MphasisWeather.lastCitySearched"

var LAST_CITY_SEARCHED: String {
    get {
        guard let rawValue = UserDefaults.standard.string(forKey: lastCitySearchedUserDefaultKey) else { return "" }
        return rawValue
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: lastCitySearchedUserDefaultKey)
    }
}
