//
//  Endpoints.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension Endpoints {
  enum Sessions {
    /// Get all session endpoint.
    case getAll

    /// Get a specific session endpoint.
    /// - Parameters:
    ///   - sessionKey The unique session key to get.
    case getOne(sessionKey: Int)
  }
}

extension Endpoints.Sessions: PodiumEndpoint {
  var path: String {
    switch self {
    case .getAll:
      "/sessions"
    case .getOne(let sessionKey):
      "/sessions/\(sessionKey)/cars"
    }
  }
}
