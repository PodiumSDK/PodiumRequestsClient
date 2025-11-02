//
//  TeamDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 13/06/2025.
//

import Foundation

struct TeamDomain: Decodable {
  /// The team name.
  let name: String

  /// The team color
  let color: String

  /// The team URL.
  let image: URL?
}
