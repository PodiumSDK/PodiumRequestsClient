//
//  CarDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 3/5/25.
//

import Foundation

/// Represent a car during a session, from the API.
struct CarDomain: Decodable {
  /// The car unique number.
  let number: Int

  /// The current driver in the car.
  let driver: DriverDomain
}
