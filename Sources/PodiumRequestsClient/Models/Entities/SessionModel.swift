//
//  SessionModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/24.
//

import Foundation

@Observable
class SessionModel: Identifiable, Equatable {
  // MARK: Properties
  /// The session key.
  var key: Int

  /// The session location.
  var location: String

  /// The session name.
  var name: String

  /// The session start date.
  var start: Date

  /// The session end date.
  var end: Date

  // MARK: Lifecycle
  init(key: Int, location: String, name: String, start: Date, end: Date) {
    self.key = key
    self.location = location
    self.name = name
    self.start = start
    self.end = end
  }

  // MARK: Methods
  static func == (lhs: SessionModel, rhs: SessionModel) -> Bool {
    lhs.key == rhs.key
  }
}
