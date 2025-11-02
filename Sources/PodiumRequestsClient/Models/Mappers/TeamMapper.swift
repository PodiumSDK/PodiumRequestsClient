//
//  TeamMapper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/13/25.
//

import Foundation
import SwiftUI

enum TeamMapper {
  /// Map a `TeamDomain` into a `TeamModel`.
  /// - Parameters:
  ///   - domain the team domain object
  /// - Returns: A team model.
  static func map(from domain: TeamDomain) -> TeamModel {
    TeamModel(
      name: domain.name,
      color: Color(hex: domain.color),
      image: domain.image
    )
  }
}

enum TeamMockMapper {
  static func map() -> TeamModel {
    TeamModel(
      name: "Ferrari HP",
      color: Color(hex: "#EF1A2D"),
      image: URL(string: "https://media.formula1.com/content/dam/fom-website/teams/2025/ferrari-logo.png")
    )
  }
}
