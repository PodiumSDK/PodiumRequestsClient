//
//  Drivers.swift
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
  }
}

extension Endpoints.Drivers: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll(let sessionKey):
      "/sessions/\(sessionKey)/drivers"
    }
  }
}
