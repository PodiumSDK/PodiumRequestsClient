//
//  CarModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 3/5/25.
//

import Foundation

/// Represent a car during a session.
/// - Note: The car is identified by its `number` property.
struct CarModel: Identifiable, Equatable, Hashable {
  // MARK: Computed Properties
  /// The car unique identifier.
  var id: Int {
    number
  }

  // MARK: Properties
  /// The car unique number.
  let number: Int

  /// The current driver in the car.
  let driver: DriverModel

  // MARK: Static Methods
  /// Compare two `CarModel` using their unique number.
  static func == (lhs: CarModel, rhs: CarModel) -> Bool {
    lhs.number == rhs.number
  }
}
