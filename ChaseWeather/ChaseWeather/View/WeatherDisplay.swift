//
//  WeatherDisplay.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct WeatherDisplay: View {

    /// error captured by the struct wide variable when API throws an error.
    @State var error: Error? = nil
    @ObservedObject var weatherDisplayViewModel = WeatherDisplayViewModel(
        service: NetworkService()
    )
    
    var body: some View {
        ZStack {
            let backgroundImageName = weatherDisplayViewModel.weatherData?.weather.first?.iconCode ?? "01d"
            let isDay = backgroundImageName.last == "d"
            Image(weatherDisplayViewModel.imageFromIconCode(backgroundImageName))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                /// Contains WeatherData text for the user to see that needs to be within a ScrollView for when phone is in landscape mode.
                if let weatherData = weatherDisplayViewModel.weatherData, let weatherIcon = weatherDisplayViewModel.icon {
                    VStack(spacing: 12) {
                        Spacer(minLength: 50)
                        WeatherText(text: weatherData.name, isDay: isDay)
                            .font(.system(size: 36))
                        Image(uiImage: weatherIcon)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        let summaryArray = weatherData.weather.compactMap { $0.summary }
                        if !summaryArray.isEmpty {
                            WeatherText(text: summaryArray.first!.capitalizedSentence, isDay: isDay)
                        }
                        let currentTempF = Int(weatherData.main.tempInFahrenheit.rounded())
                        let currentTempC = Int(weatherData.main.tempInCelsius.rounded())
                        WeatherText(text: "\(currentTempF)F / \(currentTempC)C", isDay: isDay)
                        let feelsLikeTempF = Int(weatherData.main.feelsLikeInFahrenheit.rounded())
                        let feelsLikeTempC = Int(weatherData.main.feelsLikeInCelsius.rounded())
                        WeatherText(text: "Feels like \(feelsLikeTempF)F / \(feelsLikeTempC)C", isDay: isDay)
                        let maxTempF = Int(weatherData.main.maxTempInFahrenheit.rounded())
                        let maxTempC = Int(weatherData.main.maxTempInCelsius.rounded())
                        WeatherText(text: "Today's high: \(maxTempF)F / \(maxTempC)C", isDay: isDay)
                        let minTempF = Int(weatherData.main.minTempInFahrenheit.rounded())
                        let minTempC = Int(weatherData.main.minTempInCelsius.rounded())
                        WeatherText(text: "Today's low: \(minTempF)F / \(minTempC)C", isDay: isDay)
                        WeatherText(text: "Humidity: \(weatherData.main.humidity)%", isDay: isDay)
                        let windSpeed = Int(weatherData.wind.speedInMPH.rounded())
                        WeatherText(text: "Wind blowing \(weatherDisplayViewModel.getDirectionFromDegrees(weatherData.wind.degrees)) at \(windSpeed) mph", isDay: isDay)
                        WeatherText(text: "Sunrise at \(weatherData.sunriseAsTime)", isDay: isDay)
                        WeatherText(text: "Sunset at \(weatherData.sunsetAsTime)", isDay: isDay)
                        Spacer(minLength: 50)
                    }
                }
            }.defaultScrollAnchor(.top)
        }.onAppear(perform: {
            Task {
                do {
                    try await weatherDisplayViewModel.fetchData()
                } catch {
                    self.error = error
                }
            }
        })
        .errorAlert(error: $error)
    }
    

}

extension View {
    /// Function produces an error alert when an error thrown is detected. There is  a simple "OK" button for dismissing the alert.
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.localizedDescription ?? "")
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    /// localizedDescription shown during error handling.
    var localizedDescription: String? {
        underlyingError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}

extension String {
    ///Returns a string of all lowercased characters except for the first character, which is capitalized.
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
