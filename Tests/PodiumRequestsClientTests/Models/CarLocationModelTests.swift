//
//  CarLocationModelTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/5/25.
//

import Foundation
@testable import PodiumRequestsClient
import Spatial
import Testing

@Suite()
struct CarLocationModelTests {
  @Test
  func createModel() async throws {
    let date: Date = .now
    let location: Point3D = Point3D(
      x: 150,
      y: 200,
      z: 150
    )
    let model: CarLocationModel = CarLocationModel(
      date: date,
      location: location
    )

    #expect(model.id == DateHelper.toIdentifier(date: date))
    #expect(model.date == date)
    #expect(model.location == location)
  }
}
