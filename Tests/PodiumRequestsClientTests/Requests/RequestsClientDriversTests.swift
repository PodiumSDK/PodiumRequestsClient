//
//  RequestsClientDriversTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation
import PodiumRequestsClient
import Testing

@Suite(.tags(.drivers))
struct RequestsClientDriversTests {
    let sessionKey: Int = 9094
    let driverNumber: Int = 16
    let client: RequestsClient = RequestsClient(
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

    @Test
    func getAllDriversReturnsUniqueNumbers() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)
        let driverNumbers = drivers.map { $0.number }
        let uniqueNumbers = Set(driverNumbers)

        #expect(driverNumbers.count == uniqueNumbers.count)
    }

    @Test
    func getAllDriversReturnsUniqueAcronyms() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)
        let acronyms = drivers.map { $0.acronym }
        let uniqueAcronyms = Set(acronyms)

        #expect(acronyms.count == uniqueAcronyms.count)
    }

    @Test
    func getAllDriversHaveValidData() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        for driver in drivers {
            #expect(driver.number > 0)
            #expect(driver.acronym.count == 3)
            #expect(!driver.firstname.isEmpty)
            #expect(!driver.lastname.isEmpty)
            #expect(!driver.team.name.isEmpty)
        }
    }

    @Test
    func getDriverReturnsConsistentDataWithGetAll() async throws {
        let allDrivers = try await client.getAllDrivers(sessionKey: sessionKey)
        let singleDriver = try await client.getDriver(sessionKey: sessionKey, driver: driverNumber)
        let matchingDriver = try #require(allDrivers.first(where: { $0.number == driverNumber }))

        #expect(singleDriver.number == matchingDriver.number)
        #expect(singleDriver.acronym == matchingDriver.acronym)
        #expect(singleDriver.firstname == matchingDriver.firstname)
        #expect(singleDriver.lastname == matchingDriver.lastname)
        #expect(singleDriver.team.name == matchingDriver.team.name)
    }

    @Test
    func getMultipleSpecificDrivers() async throws {
        let verstappen = try await client.getDriver(sessionKey: sessionKey, driver: 1)
        let hamilton = try await client.getDriver(sessionKey: sessionKey, driver: 44)
        let leclerc = try await client.getDriver(sessionKey: sessionKey, driver: 16)

        #expect(verstappen.acronym == "VER")
        #expect(hamilton.acronym == "HAM")
        #expect(leclerc.acronym == "LEC")
    }

    @Test
    func getDriverWithInvalidNumberThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getDriver(sessionKey: sessionKey, driver: 999)
        }
    }

    @Test
    func getDriverWithNegativeNumberThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getDriver(sessionKey: sessionKey, driver: -1)
        }
    }

    @Test
    func getDriverWithInvalidSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getDriver(sessionKey: -1, driver: driverNumber)
        }
    }

    @Test(.bug("https://github.com/EpitechPromo2026/G-EIP-700-REN-7-1-eip-mathis.le-bonniec/issues/113"), .disabled())
    func getAllDriversWithInvalidSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getAllDrivers(sessionKey: 999999)
        }
    }

    @Test
    func allDriverAcronymsAreUppercase() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        for driver in drivers {
            #expect(driver.acronym == driver.acronym.uppercased())
        }
    }

    @Test
    func driversHaveValidTeamImages() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        for driver in drivers {
            if let imageURL = driver.team.image {
                #expect(imageURL.scheme == "http" || imageURL.scheme == "https")
            }
        }
    }

    @Test
    func teammatesShareSameTeam() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)
        let ferrariDrivers = drivers.filter { $0.team.name == "Ferrari" }

        #expect(ferrariDrivers.count == 2)
        let teamNames = Set(ferrariDrivers.map { $0.team.name })
        #expect(teamNames.count == 1)
    }

    @Test
    func getDriverMultipleTimesReturnsConsistentData() async throws {
        let driver1 = try await client.getDriver(sessionKey: sessionKey, driver: driverNumber)
        let driver2 = try await client.getDriver(sessionKey: sessionKey, driver: driverNumber)

        #expect(driver1.number == driver2.number)
        #expect(driver1.acronym == driver2.acronym)
        #expect(driver1.firstname == driver2.firstname)
        #expect(driver1.lastname == driver2.lastname)
        #expect(driver1.team.name == driver2.team.name)
    }

    @Test
    func allDriversHaveValidNumbers() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        for driver in drivers {
            #expect(driver.number >= 1)
            #expect(driver.number <= 99)
        }
    }

    @Test
    func driverNamesDoNotContainExtraWhitespace() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        for driver in drivers {
            #expect(driver.firstname == driver.firstname.trimmingCharacters(in: .whitespaces))
            #expect(driver.lastname == driver.lastname.trimmingCharacters(in: .whitespaces))
        }
    }

    @Test
    func getAllDriversReturnsF1GridSize() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)

        // F1 grid has 20 drivers (10 teams × 2 drivers)
        #expect(drivers.count == 20)
    }

    @Test
    func getDriverForTeammates() async throws {
        let leclerc = try await client.getDriver(sessionKey: sessionKey, driver: 16)
        let sainz = try await client.getDriver(sessionKey: sessionKey, driver: 55)

        #expect(leclerc.team.name == sainz.team.name)
        #expect(leclerc.team.name == "Ferrari")
        #expect(leclerc.number != sainz.number)
    }

    @Test
    func driverAcronymMatchesExpectedFormat() async throws {
        let driver = try await client.getDriver(sessionKey: sessionKey, driver: driverNumber)

        #expect(driver.acronym.count == 3)
        #expect(driver.acronym.allSatisfy { $0.isLetter || $0.isNumber })
        #expect(driver.acronym.allSatisfy { $0.isUppercase || $0.isNumber })
    }

    @Test
    func getAllDriversIncludesExpectedDriver() async throws {
        let drivers = try await client.getAllDrivers(sessionKey: sessionKey)
        let hasLeclerc = drivers.contains(where: { $0.number == 16 && $0.acronym == "LEC" })

        #expect(hasLeclerc)
    }
}
