//
//  Coordinator.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

/// I would have built this out further, but there was only one screen being presented and dismissed. In other words, for the purposes of this project, this was all that was needed, but if this were a bigger app, I would have built navigation paths and the like.
class Coordinator: ObservableObject {

    @ViewBuilder
    func view() -> some View {
        WeatherDisplay()
    }
}
