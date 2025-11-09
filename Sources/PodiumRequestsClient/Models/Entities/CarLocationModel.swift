//
//  CarLocationModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/24.
//

import Foundation
import Spatial

/// A single sampled location of a car.
public struct CarLocationModel: Identifiable, Hashable {
  // MARK: Computed Properties
  /// A stable identifier derived from the `date` using `DateHelper.toIdentifier(date:)`.
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  // MARK: Properties
  /// The timestamp when the car location sample was recorded.
  public let date: Date

  /// The 3D coordinates of the car at `date`, expressed as a `Point3D`.
  public let location: Point3D

  // MARK: Lifecycle
  /// Creates a new car location sample.
  /// - Parameters:
  ///   - date: The timestamp when the location was recorded.
  ///   - location: The 3D coordinates of the car at the given timestamp.
  public init(date: Date, location: Point3D) {
    self.date = date
    self.location = location
  }
}
