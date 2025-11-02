//
//  DriverModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 2/18/25.
//

import Foundation

public class DriverModel: Hashable, Equatable, Identifiable {
  // MARK: Properties
  public var id: Int {
    number
  }

  /// The driver firstname.
  public let firstname: String

  /// The driver lastname.
  public let lastname: String

  /// The driver acronym.
  public let acronym: String

  /// The driver number.
  public let number: Int

  /// The driver team.
  public let team: TeamModel

  /// The driver image, if any.
  public let image: String?

  // MARK: Lifecycle
  public init(firstname: String, lastname: String, acronym: String, number: Int, team: TeamModel, image: String?) {
    self.firstname = firstname
    self.lastname = lastname
    self.acronym = acronym
    self.number = number
    self.team = team
    self.image = image
  }

  // MARK: Static methods
  /// Compare two `DriverModel` using their `number` property.
  public static func == (lhs: DriverModel, rhs: DriverModel) -> Bool {
    return lhs.number == rhs.number
  }

  public func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }
}
