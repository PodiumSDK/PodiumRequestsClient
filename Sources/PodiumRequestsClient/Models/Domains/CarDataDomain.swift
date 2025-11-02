//
//  CarDataDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/26/25.
//

import Foundation

struct CarDataDomain: Decodable {
  /// The date of the car data.
  let date: Date

  /// The brake percentage.
  let brake: Int

  /// The throttle percentage
  let throttle: Int

  /// The current car gear.
  let gear: Int

  /// The RPM of the engine.
  let rpm: Int

  /// The speed of the car, in km/h.
  let speed: Int

  /// The DRS activation state
  let drs: Bool?
}
