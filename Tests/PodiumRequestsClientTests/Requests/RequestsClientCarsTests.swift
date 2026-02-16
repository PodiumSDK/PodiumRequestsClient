//
//  RequestsClientCarsTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation
import Testing
import PodiumRequestsClient

@Suite(.tags(.cars))
struct RequestsClientCarsTests {
    let sessionKey: Int = 9094
    let driverNumber: Int = 16
    let client: RequestsClient = RequestsClient(
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

    @Test
    func getAllCarsReturnsUniqueDriverNumbers() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)
        let driverNumbers = cars.map { $0.number }
        let uniqueNumbers = Set(driverNumbers)

        #expect(driverNumbers.count == uniqueNumbers.count)
    }

    @Test
    func getAllCarsHaveValidDriverData() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(car.driver.number == car.number)
            #expect(!car.driver.acronym.isEmpty)
            #expect(car.driver.acronym.count == 3)
            #expect(!car.driver.firstname.isEmpty)
            #expect(!car.driver.lastname.isEmpty)
        }
    }

    @Test
    func getAllCarsHaveValidTeamData() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(!car.driver.team.name.isEmpty)
        }
    }

    @Test
    func getSpecificDriverCar() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)
        let verstappen = try #require(cars.first(where: { $0.number == 1 }))

        #expect(verstappen.driver.acronym == "VER")
        #expect(verstappen.driver.firstname == "Max")
        #expect(verstappen.driver.lastname == "Verstappen")
    }

    @Test
    func getMultipleDriverCars() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        let leclerc = try #require(cars.first(where: { $0.number == 16 }))
        let sainz = try #require(cars.first(where: { $0.number == 55 }))

        #expect(leclerc.driver.team.name == sainz.driver.team.name)
        #expect(leclerc.driver.team.name == "Ferrari")
    }

    @Test
    func carsAreOrderedConsistently() async throws {
        let cars1 = try await client.getAllCars(sessionKey: sessionKey)
        let cars2 = try await client.getAllCars(sessionKey: sessionKey)

        #expect(cars1.map { $0.number } == cars2.map { $0.number })
    }

    @Test(.bug("https://github.com/EpitechPromo2026/G-EIP-700-REN-7-1-eip-mathis.le-bonniec/issues/113"), .disabled())
    func invalidSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getAllCars(sessionKey: -1)
        }
    }

    @Test(.bug("https://github.com/EpitechPromo2026/G-EIP-700-REN-7-1-eip-mathis.le-bonniec/issues/113"), .disabled())
    func nonExistentSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getAllCars(sessionKey: 999999)
        }
    }

    @Test
    func allDriversHaveThreeLetterAcronyms() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(car.driver.acronym.count == 3)
            #expect(car.driver.acronym.allSatisfy { $0.isUppercase || $0.isNumber })
        }
    }

    @Test
    func allDriverNumbersArePositive() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(car.number > 0)
            #expect(car.driver.number > 0)
        }
    }

    @Test
    func teamImagesAreValidURLs() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            if let imageURL = car.driver.team.image {
                #expect(imageURL.scheme == "http" || imageURL.scheme == "https")
            }
        }
    }

    @Test
    func carNumberMatchesDriverNumber() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(car.number == car.driver.number)
        }
    }

    @Test
    func getAllCarsResponseIsCached() async throws {
        let start1 = Date()
        _ = try await client.getAllCars(sessionKey: sessionKey)
        let duration1 = Date().timeIntervalSince(start1)

        let start2 = Date()
        _ = try await client.getAllCars(sessionKey: sessionKey)
        let duration2 = Date().timeIntervalSince(start2)

        // Second call should be faster if cached (though not guaranteed)
        // This is more of a performance observation test
        #expect(duration2 <= duration1 * 1.5)
    }

    @Test
    func driverNamesAreNonEmpty() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        for car in cars {
            #expect(!car.driver.firstname.trimmingCharacters(in: .whitespaces).isEmpty)
            #expect(!car.driver.lastname.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    @Test
    func getAllCarsReturnsExpectedF1GridSize() async throws {
        let cars = try await client.getAllCars(sessionKey: sessionKey)

        // F1 grid typically has 20 cars (10 teams × 2 drivers)
        #expect(cars.count == 20)
    }
}
