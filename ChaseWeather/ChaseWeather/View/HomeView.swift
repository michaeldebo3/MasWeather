//
//  ContentView.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct HomeView: View {
    
    /// Handles location related permisisions as well as last known location.
    @StateObject private var locationManager = LocationManager()
    /// Contains the user default `LAST_CITY_SEARCHED` value.
    @State var city = LAST_CITY_SEARCHED
    /// Determines when to display the WeatherDisplay view.
    @State var isShowingWeather = false
    let vm = HomeViewModel(service: NetworkService())
    @State var error: Error? = nil
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .indigo, .purple]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                Image("sunBehindCloud")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                    .foregroundStyle(.tint)
                TextField("City", text: $city)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.title)
                BigButton(text: "Get weather for selected city") {
                    LAST_CITY_SEARCHED = city
                    isShowingWeather = true
                }
                .sheet(isPresented: $isShowingWeather) {
                    let coordinator = Coordinator()
                    coordinator.view()
                }
                BigButton(text: "Get weather for your current location") {
                    Task {
                        await getWeatherByCoordinates()
                    }
                }
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
            Task {
                await getWeatherByCoordinates()
            }
        }
        .errorAlert(error: $error)
    }
    
    /// Sets the `LAST_CITY_SEARCHED` to the name of the user's location when possible, e.g. after appropriate permissions have been given. Otherwise an error is handled. If there is no error, then the DisplayWeather view is launched.
    func getWeatherByCoordinates() async {
        if let coordinate = locationManager.lastKnownLocation {
            do {
                LAST_CITY_SEARCHED = try await vm.fetchLocationName(lat: coordinate.latitude, long: coordinate.longitude)
                isShowingWeather = true
            } catch {
                self.error = error
            }
        }
    }
}
