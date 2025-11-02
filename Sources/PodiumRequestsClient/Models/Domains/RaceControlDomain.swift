//
//  RaceControlDomain.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 7/3/25.
//

import Foundation

struct RaceControlDomain: Decodable {
  /// The race control message category
  let category: String

  /// The race control message date.
  let date: Date

  /// The optional race control message flag.
  let flag: String?

  /// The optional race control message sector.
  let sector: Int?

  /// The race control lap number that the message occured.
  let lap: Int?

  /// The race control message.
  let message: String
}
