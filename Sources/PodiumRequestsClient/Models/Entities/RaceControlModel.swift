//
//  RaceControlModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 7/3/25.
//

import Foundation

public enum RaceControlCategory: String {
  case drs = "Drs"
  case other = "Other"
  case flag = "Flag"

  public init(rawValue: String) {
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

public enum RaceControlFlag: String {
  case yellow = "YELLOW"
  case doubleYellow = "DOUBLE YELLOW"
  case red = "RED"
  case green = "GREEN"
}

public struct RaceControlModel: Identifiable {
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  public let category: RaceControlCategory

  public let date: Date

  public let flag: RaceControlFlag?

  public let sector: Int?

  public let lap: Int?

  public let message: String
}
