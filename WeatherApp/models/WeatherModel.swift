//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import Foundation

typealias ICodable = Decodable & Encodable

struct WeatherResponse: Decodable, Encodable {
    let location: Location
    let current: Target
}

struct Location: Decodable, Encodable {
    let name: String
    let region: String
    let country: String
}

struct Target: Decodable, Encodable {
    let temperature: Double
    let condition: Condition
    let uv: Double
    let humidity: Double
    let feelslike: Double

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp_c", feelslike = "feelslike_c", condition, uv, humidity
    }
}

struct Condition: Decodable, Encodable {
    let text: String
    let icon: String
}
