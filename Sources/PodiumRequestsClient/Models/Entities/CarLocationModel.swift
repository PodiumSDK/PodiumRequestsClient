//
//  CarLocationModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/24.
//

import Foundation
import Spatial

public struct CarLocationModel: Identifiable, Hashable {
  // MARK: Computed Properties
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  // MARK: Properties
  /// The car location date
  public let date: Date

  /// The car location coordinates
  public let location: Point3D

  // MARK: Lifecycle
  public init(date: Date, location: Point3D) {
    self.date = date
    self.location = location
  }
}
