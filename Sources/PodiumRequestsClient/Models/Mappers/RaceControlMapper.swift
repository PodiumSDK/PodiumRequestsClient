//
//  RaceControlMapper.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 7/1/25.
//

import Foundation

enum RaceControlMapper {
  static func map(from domain: RaceControlDomain) -> RaceControlModel {
    RaceControlModel(
      category: RaceControlCategory(rawValue: domain.category),
      date: domain.date,
      flag: domain.flag.flatMap { RaceControlFlag(rawValue: $0) },
      sector: domain.sector,
      lap: domain.lap,
      message: domain.message
    )
  }
}
