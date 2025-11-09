//
//  Endpoints.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

/// A protocol describing API endpoints that can resolve to a URL path.
protocol PodiumEndpoint {
  /// The URL path that'll be resolved from the enum.
  var path: String { get }
}

/// A namespace for endpoint groups used by the Podium API client.
enum Endpoints {}
