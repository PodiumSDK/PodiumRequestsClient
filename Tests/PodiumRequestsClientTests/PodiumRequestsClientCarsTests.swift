//
//  PodiumRequestsClientCarsTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Testing
import PodiumRequestsClient

@Suite(.tags(.cars))
struct PodiumRequestsClientCarsTests {
  let sessionKey: Int = 9094
  let driverNumber: Int = 16
  let client: PodiumRequestsClient = PodiumRequestsClient(
    baseURL: "https://api.podium.mathislebonniec.fr/v1/formula1",
    apiKey: "08fe5ccd-8d72-49e0-ae2b-3f097f2b96a1"
  )

  @Test
  func getAllCars() async throws {
    let cars = try await client.getAllCars(sessionKey: sessionKey)

    #expect(cars.count == 20)
  }

  // getCar(sessionKey:driver) hasn't been implemented yet.
  @Test()
  func getOneCar() async throws {
    let cars = try await client.getAllCars(sessionKey: sessionKey)
    let first = try #require(cars.first(where: { $0.number == driverNumber }))

    #expect(first.number == driverNumber)
    #expect(first.driver.number == driverNumber)
    #expect(first.driver.acronym == "LEC")
    #expect(first.driver.firstname == "Charles")
    #expect(first.driver.lastname == "Leclerc")
    #expect(first.driver.team.name == "Ferrari")
    #expect(first.driver.team.image != nil)
  }
}
