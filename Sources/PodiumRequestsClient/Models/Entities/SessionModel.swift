//
//  SessionModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/24.
//

import Foundation

/// Describe a session, with an ID, location, name, start and end.
/// A session can be  a race, qualifications, free practice etc.
@Observable
public class SessionModel: Identifiable, Equatable {
  // MARK: Properties
  /// The session key.
  public var key: Int

  /// The session location.
  public var location: String

  /// The session name.
  public var name: String

  /// The session start date.
  public var start: Date

  /// The session end date.
  public var end: Date

  // MARK: Lifecycle
  /// Creates a new session.
  /// - Parameters:
  ///   - key: The session's unique key.
  ///   - location: The session's location name.
  ///   - name: The session's name.
  ///   - start: The session's start date.
  ///   - end: The session's end date.
  public init(key: Int, location: String, name: String, start: Date, end: Date) {
    self.key = key
    self.location = location
    self.name = name
    self.start = start
    self.end = end
  }

  // MARK: Methods
  /// Compare two `SessionModel` using their `key` property.
  public static func == (lhs: SessionModel, rhs: SessionModel) -> Bool {
    lhs.key == rhs.key
  }
}
