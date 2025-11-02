//
//  CarModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 3/5/25.
//

import Foundation

/// Represent a car during a session.
/// - Note: The car is identified by its `number` property.
public struct CarModel: Identifiable, Equatable, Hashable {
  // MARK: Computed Properties
  /// The car unique identifier.
  public var id: Int {
    number
  }

  // MARK: Properties
  /// The car unique number.
  public let number: Int

  /// The current driver in the car.
  public let driver: DriverModel

  // MARK: Static Methods
  /// Compare two `CarModel` using their unique number.
  public static func == (lhs: CarModel, rhs: CarModel) -> Bool {
    lhs.number == rhs.number
  }
}
