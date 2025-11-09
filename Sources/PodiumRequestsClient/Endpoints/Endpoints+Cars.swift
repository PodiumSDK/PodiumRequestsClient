//
//  Endpoints+Cars.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  /// Endpoints for cars.
  enum Cars {
    /// Get all cars for a session.
    /// - Parameter sessionKey: The session key.
    case getAll(sessionKey: Int)

    /// Get all locations for a car.
    /// - Parameters:
    ///   - sessionKey: The session key.
    ///   - driver: The car number.
    case getLocations(sessionKey: Int, driver: Int)

    /// Get all telemetry for a car.
    /// - Parameters:
    ///   - sessionKey: The session key.
    ///   - driver: The car number.
    case getTelemetry(sessionKey: Int, driver: Int)
  }
}

extension Endpoints.Cars: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll(let sessionKey):
      "/sessions/\(sessionKey)/cars"
    case .getLocations(let sessionKey, let driver):
      "/sessions/\(sessionKey)/cars/\(driver)/locations"
    case .getTelemetry(let sessionKey, let driver):
      "/sessions/\(sessionKey)/cars/\(driver)/data"
    }
  }
}
