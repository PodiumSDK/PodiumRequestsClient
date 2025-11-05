//
//  DateHelperTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/5/25.
//

import Foundation
@testable import PodiumRequestsClient
import Testing

@Suite
struct DateHelperTests {
  @Test
  func dateToStringIdentifier() async throws {
    let date: Date = try Date("2003-03-06T05:30:35Z", strategy: .iso8601)
    let identifier: String = DateHelper.toIdentifier(date: date)

    #expect(identifier == "2003-03-06T05:30:35.000Z")
  }

  @Test
  func missingFractionsSeconds() async throws {
    let date: Date = try Date("2003-03-06T05:30:35Z", strategy: .iso8601)
    let identifier: String = DateHelper.toIdentifier(date: date)

    #expect(identifier != "2003-03-06T05:30:35Z")
  }
}
