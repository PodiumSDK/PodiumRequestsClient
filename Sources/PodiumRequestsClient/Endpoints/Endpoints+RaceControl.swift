//
//  Endpoints+RaceControl.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  enum RaceControl {
    /// Get all the race controls for a specific session.
    /// - Parameters:
    ///   - sessionKey The unique session key to get all the race control.
    case getAll(sessionKey: Int)
  }
}

extension Endpoints.RaceControl: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll(let sessionKey):
      "/sessions/\(sessionKey)/race-control"
    }
  }
}
