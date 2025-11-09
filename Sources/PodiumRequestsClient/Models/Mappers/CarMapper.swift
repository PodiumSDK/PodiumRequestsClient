//
//  CarMapper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 2/18/25.
//

import Foundation
import Spatial

/// Maps car-related domain objects to public models.
enum CarMapper {
  /// Map a `CarDomain` into a `CarModel`.
  /// - Parameters:
  ///   - domain the car domain object
  /// - Returns: A car model.
  static func map(from domain: CarDomain) -> CarModel {
    CarModel(
      number: domain.number,
      driver: DriverMapper.map(domain: domain.driver)
    )
  }

  /// Map a `CarLocationDomain` into a `CarLocationModel`.
  /// - Parameters:
  ///   - domain the car location domain object
  /// - Note: `y` and `z` axis are inverted to follow SwiftUI spatial conventions.
  /// - Returns: A car location model.
  static func map(from domain: CarLocationDomain) -> CarLocationModel {
    CarLocationModel(
      date: domain.date,
      location: Point3D(
        x: domain.x,
        y: domain.z,
        z: domain.y
      )
    )
  }

  /// Map a `CarTelemetryDomain` into a `CarTelemetryModel`.
  /// - Parameters:
  ///   - domain the car telemetry domain object
  /// - Returns: A car telemetry model.
  static func map(from domain: CarTelemetryDomain) -> CarTelemetryModel {
    CarTelemetryModel(
      date: domain.date,
      brake: domain.brake,
      throttle: domain.throttle,
      gear: domain.gear,
      rpm: domain.rpm,
      speed: domain.speed,
      drs: domain.drs
    )
  }
}

/// Provides mock car telemetry data for previews and tests.
enum CarMockMapper {
  static func map() -> CarTelemetryModel {
    CarTelemetryModel(
      date: .now,
      brake: 0,
      throttle: 78,
      gear: 5,
      rpm: 10263,
      speed: 254,
      drs: false
    )
  }
}

