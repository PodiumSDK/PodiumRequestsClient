//
//  PodiumRequestsClientDriversTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation
import PodiumRequestsClient
import Testing

@Suite(.tags(.drivers))
struct PodiumRequestsClientDriversTests {
  let sessionKey: Int = 9094
  let driverNumber: Int = 16
  let client: PodiumRequestsClient = PodiumRequestsClient(
    baseURL: "https://api.podium.mathislebonniec.fr/v1/formula1",
    apiKey: "08fe5ccd-8d72-49e0-ae2b-3f097f2b96a1"
  )

  @Test
  func getAllDrivers() async throws {
    let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

    #expect(drivers.count == 20)
  }

  @Test
  func getOneDriver() async throws {
    let driver = try await client.getDriver(sessionKey: sessionKey, driver: driverNumber)

    #expect(driver.number == driverNumber)
    #expect(driver.acronym == "LEC")
    #expect(driver.firstname == "Charles")
    #expect(driver.lastname == "Leclerc")
    #expect(driver.team.name == "Ferrari")
    #expect(driver.team.image != nil)
  }
}
