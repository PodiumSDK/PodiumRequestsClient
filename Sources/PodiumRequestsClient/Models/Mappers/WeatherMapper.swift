//
//  WeatherMapper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 12/21/25.
//

import Foundation

enum WeatherMapper {
    /// Maps a `WeatherDomain` instance to a `WeatherModel` instance.
    /// 
    /// - Parameters:
    ///   - domain: The domain model representing weather data to map from.
    /// - Returns: A `WeatherModel` created from the given domain model, with all relevant properties converted accordingly.
    static func map(from domain: WeatherDomain) -> WeatherModel {
        WeatherModel(
            date: domain.date,
            humidity: domain.humidity,
            pressure: domain.pressure,
            rainfall: domain.rainfall != 0,
            temperature: WeatherMapper.map(from: domain.temperature),
            wind: WeatherMapper.map(from: domain.wind)
        )
    }

    /// Maps a `WeatherDomain.Temperature` instance to a `WeatherModel.Temperature` instance.
    ///
    /// - Parameters:
    ///   - domain: The domain temperature model to map from.
    /// - Returns: A `WeatherModel.Temperature` instance representing the mapped temperature data.
    static func map(from domain: WeatherDomain.Temperature) -> WeatherModel.Temperature {
        WeatherModel.Temperature(
            track: domain.track,
            air: domain.air
        )
    }

    /// Maps a `WeatherDomain.Wind` instance to a `WeatherModel.Wind` instance.
    ///
    /// - Parameters:
    ///   - domain: The domain wind model to map from.
    /// - Returns: A `WeatherModel.Wind` instance representing the mapped wind data.
    static func map(from domain: WeatherDomain.Wind) -> WeatherModel.Wind {
        WeatherModel.Wind(
            direction: domain.direction,
            speed: domain.speed
        )
    }
}
