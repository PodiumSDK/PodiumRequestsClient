//
//  DriverMapper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 2/18/25.
//

import Foundation

enum DriverMapper {
  /// Map a `DriverDomain` into a `DriverDomain`.
  static func map(from domain: DriverDomain) -> DriverModel {
    DriverModel(
      firstname: domain.firstname,
      lastname: domain.lastname,
      acronym: domain.acronym,
      number: domain.number,
      team: TeamMapper.map(from: domain.team),
      image: domain.image
    )
  }
}

// swiftlint:disable line_length
enum DriverMockMapper {
  static func map() -> DriverModel {
    DriverModel(
      firstname: "Charles",
      lastname: "Leclerc",
      acronym: "LEC",
      number: 16,
      team: TeamMockMapper.map(),
      image: "https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png.transform/1col/image.png"
    )
  }

  static func map() -> [DriverModel] {
    [
      DriverModel(
        firstname: "Charles",
        lastname: "Leclerc",
        acronym: "LEC",
        number: 16,
        team: TeamMockMapper.map(),
        image: "https://media.formula1.com/d_driver_fallback_image.png/content/dam/fom-website/drivers/C/CHALEC01_Charles_Leclerc/chalec01.png.transform/1col/image.png"
      ),
      DriverModel(
        firstname: "Lewis",
        lastname: "Hamilton",
        acronym: "HAM",
        number: 44,
        team: TeamMockMapper.map(),
        image: "https://www.formula1.com/content/dam/fom-website/drivers/L/LEWHAM01_Lewis_Hamilton/lewham01.png.transform/1col/image.png"
      )
    ]
  }
}
// swiftlint:enable line_length
