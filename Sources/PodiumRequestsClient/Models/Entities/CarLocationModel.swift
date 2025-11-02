//
//  CarLocationModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/24.
//

import Foundation
import Spatial

struct CarLocationModel: Identifiable, Hashable {
  // MARK: Computed Properties
  var id: String {
    DateHelper.toIdentifier(date: date)
  }

  // MARK: Properties
  /// The car location date
  let date: Date

  /// The car location coordinates
  let location: Point3D
}
