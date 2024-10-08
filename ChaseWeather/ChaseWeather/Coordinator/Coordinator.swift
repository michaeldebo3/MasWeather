//
//  Coordinator.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

class Coordinator: ObservableObject {

    @ViewBuilder
    func view() -> some View {
        WeatherDisplay()
    }
}
