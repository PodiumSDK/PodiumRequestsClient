//
//  Endpoints.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

/// All endpoints enums must conform to this `PodiumEndpoint` protocol.
protocol PodiumEndpoint {
  var path: String { get }
}

enum Endpoints {}
