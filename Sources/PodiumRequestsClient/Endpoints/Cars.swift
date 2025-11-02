//
//  Cars.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  enum Cars {
    /// Get all cars for a given session.
    /// - Parameters:
    ///   - sessionKey The unique session key to get the cars
    case getAll(sessionKey: Int)

    /// Get all locations for a given car.
    /// - Parameters:
    ///   - sessionKey The unique session key to get the car.
    ///   - driver The unique car number to get all the locations.
    case getLocations(sessionKey: Int, driver: Int)

    /// Get all data for a given car.
    /// - Parameters:
    ///   - sessionKey The unique session key to get the car.
    ///   - driver The unique car number to get all the data.
    case getData(sessionKey: Int, driver: Int)
  }
}

extension Endpoints.Cars: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll(let sessionKey):
      "/sessions/\(sessionKey)/cars"
    case .getLocations(let sessionKey, let driver):
      "/sessions/\(sessionKey)/cars/\(driver)/locations"
    case .getData(let sessionKey, let driver):
      "/sessions/\(sessionKey)/cars/\(driver)/data"
    }
  }
}
