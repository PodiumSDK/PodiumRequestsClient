//
//  SessionMapper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 2/18/25.
//

import Foundation

enum SessionMapper {
  /// Map a `SessionDomain` into a `SessionModel`.
  /// - Parameters:
  ///   - domain the session domain object
  /// - Returns: A session model.
  static func map(from domain: SessionDomain) -> SessionModel {
    SessionModel(
      key: domain.key,
      location: domain.location,
      name: domain.name,
      start: domain.time.start,
      end: domain.time.end
    )
  }
}
