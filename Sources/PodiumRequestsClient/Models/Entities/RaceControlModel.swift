//
//  RaceControlModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 7/3/25.
//

import Foundation

enum RaceControlCategory: String {
  case drs = "Drs"
  case other = "Other"
  case flag = "Flag"

  init(rawValue: String) {
    switch rawValue {
    case RaceControlCategory.drs.rawValue:
      self = .drs
    case RaceControlCategory.flag.rawValue:
      self = .flag
    default:
      self = .other
    }
  }
}

enum RaceControlFlag: String {
  case yellow = "YELLOW"
  case doubleYellow = "DOUBLE YELLOW"
  case red = "RED"
  case green = "GREEN"
}

struct RaceControlModel: Identifiable {
  var id: String {
    DateHelper.toIdentifier(date: date)
  }

  let category: RaceControlCategory

  let date: Date

  let flag: RaceControlFlag?

  let sector: Int?

  let lap: Int?

  let message: String
}
