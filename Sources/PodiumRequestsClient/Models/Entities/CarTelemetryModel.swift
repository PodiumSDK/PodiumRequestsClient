//
//  CarTelemetryModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/26/25.
//

import Foundation

public struct CarTelemetryModel: Identifiable, Hashable {
  // MARK: Properties
  /// The car data model unique identifier.
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  /// The date of the car data.
  public let date: Date

  /// The brake percentage.
  public let brake: Int

  /// The throttle percentage
  public let throttle: Int

  /// The current car gear.
  public let gear: Int

  /// The RPM of the engine.
  public let rpm: Int

  /// The speed of the car, in km/h.
  public let speed: Int

  /// The DRS activation state
  public let drs: Bool?

  // MARK: Lifecycle
  public init(date: Date, brake: Int, throttle: Int, gear: Int, rpm: Int, speed: Int, drs: Bool?) {
    self.date = date
    self.brake = brake
    self.throttle = throttle
    self.gear = gear
    self.rpm = rpm
    self.speed = speed
    self.drs = drs
  }
}
