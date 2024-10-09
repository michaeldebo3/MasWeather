//
//  LastCitySearched.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

/// User defaults used to persist last city searched that prevents the user from having to type the same name upon multiple consecutive uses of the app..
let lastCitySearchedUserDefaultKey = "com.ollify.ChaseWeather.lastCitySearched"

var LAST_CITY_SEARCHED: String {
    get {
        guard let rawValue = UserDefaults.standard.string(forKey: lastCitySearchedUserDefaultKey) else { return "" }
        return rawValue
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: lastCitySearchedUserDefaultKey)
    }
}
