//
//  WeatherDisplay.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct WeatherDisplay: View {

    @State var error: Error? = nil
    @ObservedObject var weatherDisplayViewModel = WeatherDisplayViewModel(
        service: NetworkService()
    )
    
    var body: some View {
        ZStack {
            let backgroundImageName = weatherDisplayViewModel.weatherData?.weather.first?.iconCode ?? "01d"
            Image(weatherDisplayViewModel.imageFromIcon(name: backgroundImageName))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                if let weatherData = weatherDisplayViewModel.weatherData, let weatherIcon = weatherDisplayViewModel.icon {

                        VStack(spacing: 12) {
                            Spacer(minLength: 50)
                            Text(weatherData.name)
                                .font(.system(size: 36))
                            Image(uiImage: weatherIcon)
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                            let summaryArray = weatherData.weather.compactMap { $0.summary }
                            if !summaryArray.isEmpty {
                                Text(summaryArray.first!.capitalizedSentence)
                            }
                            let currentTempF = Int(weatherData.main.tempInFahrenheit.rounded())
                            let currentTempC = Int(weatherData.main.tempInCelsius.rounded())
                            Text("\(currentTempF)F / \(currentTempC)C")
                            let feelsLikeTempF = Int(weatherData.main.feelsLikeInFahrenheit.rounded())
                            let feelsLikeTempC = Int(weatherData.main.feelsLikeInCelsius.rounded())
                            Text("Feels like \(feelsLikeTempF)F / \(feelsLikeTempC)C")
                            let maxTempF = Int(weatherData.main.maxTempInFahrenheit.rounded())
                            let maxTempC = Int(weatherData.main.maxTempInCelsius.rounded())
                            Text("Today's high: \(maxTempF)F / \(maxTempC)C")
                            let minTempF = Int(weatherData.main.minTempInFahrenheit.rounded())
                            let minTempC = Int(weatherData.main.minTempInCelsius.rounded())
                            Text("Today's low: \(minTempF)F / \(minTempC)C")
                            Text("Humidity: \(weatherData.main.humidity)%")
                            let windSpeed = Int(weatherData.wind.speedInMPH.rounded())
                            Text("Wind blowing \(weatherDisplayViewModel.getDirectionFromDegrees(weatherData.wind.degrees)) at \(windSpeed) mph")
                            Text("Sunrise at \(weatherData.sunriseAsTime)")
                            Text("Sunset at \(weatherData.sunsetAsTime)")
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
    var localizedDescription: String? {
        underlyingError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
