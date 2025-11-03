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
  // MARK: Properties
  public var id: String {
    DateHelper.toIdentifier(date: date)
  }

  public let category: RaceControlCategory

  public let date: Date

  public let flag: RaceControlFlag?

  public let sector: Int?

  public let lap: Int?

  public let message: String

  // MARK: Lifecycle
  public init(
    category: RaceControlCategory,
    date: Date,
    flag: RaceControlFlag?,
    sector: Int?,
    lap: Int?,
    message: String
  ) {
    self.category = category
    self.date = date
    self.flag = flag
    self.sector = sector
    self.lap = lap
    self.message = message
  }
}
