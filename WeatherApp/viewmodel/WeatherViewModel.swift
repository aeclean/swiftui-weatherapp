//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import Foundation

enum WeatherViewState {
    case idle
    case success
    case cached
    case failure
}

class WatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var temperature: String = ""
    @Published var condition: String = ""
    @Published var humidity: String = ""
    @Published var uv: String = ""
    @Published var feelsLike: String = ""
    @Published var iconUrl: URL = URL.currentDirectory()
    @Published var state: WeatherViewState = .idle

    private let apiKey = "2da6b53b60d44e05b3d82230241812"
    private let apiURL = "https://api.weatherapi.com/v1/current.json"

    init() {
        loadLastWeather()
    }

    func fetchWeather(_ city: String) {
        guard !city.isEmpty else {
            state = .idle
            return
        }

        guard let url = URL(string: "\(apiURL)?key=\(apiKey)&q=\(city)") else {
            print("Error parsing URL")
            return
        }

        state = .idle

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                self.state = .failure
                return
            }

            guard let data = data else {
                print("Empty results")
                self.state = .failure
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.city = weatherResponse.location.name
                    self.temperature = "\(weatherResponse.current.temperature)ºC"
                    self.condition = weatherResponse.current.condition.text
                    self.humidity = "\(weatherResponse.current.humidity)%"
                    self.uv = "\(weatherResponse.current.uv)"
                    self.feelsLike = "\(weatherResponse.current.feelslike)º"
                    self.iconUrl = URL(string: "http:\(weatherResponse.current.condition.icon)") ?? URL.currentDirectory()
                    self.state = .success

                    self.storeCurrentWeather(response: weatherResponse)
                }
            } catch {
                print("Error decoding: \(error)")
                self.state = .failure
            }
        }.resume()
    }

    func storeCurrentWeather(response: WeatherResponse) {
        if let encodedData = try? JSONEncoder().encode(response) {
            UserDefaults.standard.set(encodedData, forKey: "cached")
        }
    }

    func loadLastWeather() {
        guard let savedData = UserDefaults.standard.data(forKey: "cached"),
              let storedData = try? JSONDecoder().decode(WeatherResponse.self, from: savedData) else {
            return
        }

        city = storedData.location.name
        temperature = "\(storedData.current.temperature)ºC"
        condition = storedData.current.condition.text
        humidity = "\(storedData.current.humidity)%"
        uv = "\(storedData.current.uv)"
        feelsLike = "\(storedData.current.feelslike)º"
        iconUrl = URL(string: "http:\(storedData.current.condition.icon)") ?? URL.currentDirectory()

        state = .cached
    }
}
