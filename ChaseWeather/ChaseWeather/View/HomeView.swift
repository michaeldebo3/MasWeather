//
//  ContentView.swift
//  ChaseWeather
//
//  Created by Michael deBoisblanc on 10/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State var city = LAST_CITY_SEARCHED
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
