//
//  WeatherDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 12/21/25.
//

import Foundation

struct WeatherDomain: Decodable {
    let date: Date

    let humidity: Int

    let pressure: Double

    let rainfall: Int

    let temperature: Temperature

    let wind: Wind
}

extension WeatherDomain {
    struct Temperature: Decodable {
        let track: Double

        let air: Double
    }

    struct Wind: Decodable {
        let direction: Double

        let speed: Double
    }
}
