//
//  WeatherModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 12/21/25.
//

import Foundation

/// A model representing weather conditions at a specific time and location.
///
/// `WeatherModel` encapsulates the meteorological data relevant for a particular instant, such as temperature, humidity, pressure, wind, and rainfall presence.
public struct WeatherModel: PodiumModel {
    // MARK: Properties
    public var id: String {
        DateHelper.toIdentifier(date: date)
    }

    /// The date and time for which the weather data is valid.
    public let date: Date

    ///  The relative humidity percentage (0–100%).
    public let humidity: Int

    /// The atmospheric pressure in hectopascals (hPa).
    public let pressure: Double

    /// A Boolean value indicating whether it is currently raining.
    public let rainfall: Bool

    /// A structure representing track and air temperatures in degrees Celsius.
    public let temperature: Temperature

    /// A structure representing wind direction (in degrees) and speed (in meters per second).
    public let wind: Wind

    // MARK: Lifecycle
    public init(date: Date, humidity: Int, pressure: Double, rainfall: Bool, temperature: Temperature, wind: Wind) {
        self.date = date
        self.humidity = humidity
        self.pressure = pressure
        self.rainfall = rainfall
        self.temperature = temperature
        self.wind = wind
    }

    // MARK: Methods
    public func hash(into hasher: inout Hasher) {

    }

    public static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
      lhs.date == rhs.date &&
      lhs.humidity == rhs.humidity &&
      lhs.pressure == rhs.pressure &&
      lhs.rainfall == rhs.rainfall &&
      lhs.temperature == rhs.temperature &&
      lhs.wind == rhs.wind
    }
}

extension WeatherModel {
  public struct Temperature: Equatable {
        public let track: Double

        public let air: Double

        public init(track: Double, air: Double) {
            self.track = track
            self.air = air
        }
    }

  public struct Wind: Equatable {
        public let direction: Double

        public let speed: Double

        public init(direction: Double, speed: Double) {
            self.direction = direction
            self.speed = speed
        }
    }
}
