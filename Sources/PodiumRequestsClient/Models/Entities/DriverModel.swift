//
//  DriverModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 2/18/25.
//

import Foundation

class DriverModel: Hashable, Equatable, Identifiable {
  // MARK: Properties
  var id: Int {
    number
  }

  /// The driver firstname.
  let firstname: String

  /// The driver lastname.
  let lastname: String

  /// The driver acronym.
  let acronym: String

  /// The driver number.
  let number: Int

  /// The driver team.
  let team: TeamModel

  /// The driver image, if any.
  let image: String?

  // MARK: Lifecycle
  init(firstname: String, lastname: String, acronym: String, number: Int, team: TeamModel, image: String?) {
    self.firstname = firstname
    self.lastname = lastname
    self.acronym = acronym
    self.number = number
    self.team = team
    self.image = image
  }

  // MARK: Static methods
  /// Compare two `DriverModel` using their `number` property.
  static func == (lhs: DriverModel, rhs: DriverModel) -> Bool {
    return lhs.number == rhs.number
  }

  public func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }
}
