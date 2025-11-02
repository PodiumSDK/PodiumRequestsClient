//
//  DriverDomain.swift
//  PodiumRequestsClient
//
//  Created by Raphaël Lecoq on 03/11/2024.
//

import Foundation

struct DriverDomain: Decodable, Identifiable {
  /// The unique driver ID.
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
  let team: TeamDomain

  /// The driver image, if any.
  let image: String?
}
