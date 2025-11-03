//
//  Endpoints+Drivers.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  enum Drivers {
    /// Get all drivers for a specific session.
    /// - Parameters:
    ///   - sessionKey The unique session key to get all the drivers.
    case getAll(sessionKey: Int)

    /// Get a driver for a specific session.
    /// - Parameters:
    ///   - sessionKey The unique session key to get all the drivers.
    ///   - driver The driver number to get.
    case getOne(sessionKey: Int, driver: Int)
  }
}

extension Endpoints.Drivers: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll(let sessionKey):
      "/sessions/\(sessionKey)/drivers"
    case .getOne(let sessionKey, let driver):
      "/sessions/\(sessionKey)/drivers/\(driver)"
    }
  }
}
