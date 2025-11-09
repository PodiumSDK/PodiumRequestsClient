//
//  Endpoints+Endpoints.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  /// Endpoints for sessions.
  enum Sessions {
    /// Get all sessions.
    case getAll

    /// Get a specific session.
    /// - Parameter sessionKey: The session key.
    case getOne(sessionKey: Int)
  }
}

extension Endpoints.Sessions: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll:
      "/sessions"
    case .getOne(let sessionKey):
      "/sessions/\(sessionKey)"
    }
  }
}
