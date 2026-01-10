//
//  IntervalModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

/// Describe a time interval snapshot for a driver at a given date.
///
/// An interval represents the time difference between a driver and another
/// reference, typically the leader, at a specific moment.
public struct IntervalModel: PodiumModel {
  public var id: String {
    DateHelper.toIdentifier(date: date) + String(driver)
  }

  // MARK: Properties
  /// The date at which the interval was recorded.
  public let date: Date

  /// The driver identifier.
  public let driver: Int

  /// The interval to the reference driver.
  public let interval: Float?

  /// The interval to the session leader.
  public let leader: Float?

  // MARK: Lifecycle
  /// Creates a new interval model.
  /// - Parameters:
  ///   - date: The date at which the interval was recorded.
  ///   - driver: The driver identifier.
  ///   - interval: The time interval to the reference driver.
  ///   - leader: The time interval to the session leader.
  public init(date: Date, driver: Int, interval: Float?, leader: Float?) {
    self.date = date
    self.driver = driver
    self.interval = interval
    self.leader = leader
  }
}
