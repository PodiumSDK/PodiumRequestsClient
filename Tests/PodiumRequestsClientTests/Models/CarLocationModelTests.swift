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

    @Test
    func createModelWithDifferentDates() async throws {
        let date1 = Date()
        let date2 = Date().addingTimeInterval(3600) // 1 hour later
        let location = Point3D(x: 100, y: 100, z: 100)

        let model1 = CarLocationModel(date: date1, location: location)
        let model2 = CarLocationModel(date: date2, location: location)

        #expect(model1.id != model2.id)
        #expect(model1.date != model2.date)
    }

    @Test
    func createModelWithDifferentLocations() async throws {
        let date = Date()
        let location1 = Point3D(x: 100, y: 200, z: 300)
        let location2 = Point3D(x: 400, y: 500, z: 600)

        let model1 = CarLocationModel(date: date, location: location1)
        let model2 = CarLocationModel(date: date, location: location2)

        #expect(model1.location != model2.location)
        #expect(model1.id == model2.id) // Same date = same ID
    }

    @Test
    func createModelWithZeroCoordinates() async throws {
        let date = Date()
        let location = Point3D(x: 0, y: 0, z: 0)

        let model = CarLocationModel(date: date, location: location)

        #expect(model.location.x == 0)
        #expect(model.location.y == 0)
        #expect(model.location.z == 0)
    }

    @Test
    func createModelWithNegativeCoordinates() async throws {
        let date = Date()
        let location = Point3D(x: -100, y: -200, z: -50)

        let model = CarLocationModel(date: date, location: location)

        #expect(model.location.x == -100)
        #expect(model.location.y == -200)
        #expect(model.location.z == -50)
    }

    @Test
    func createModelWithLargeCoordinates() async throws {
        let date = Date()
        let location = Point3D(x: 999999, y: 888888, z: 777777)

        let model = CarLocationModel(date: date, location: location)

        #expect(model.location == location)
    }

    @Test
    func idConsistencyWithSameDate() async throws {
        let date = Date(timeIntervalSince1970: 1609459200) // Fixed date
        let location1 = Point3D(x: 10, y: 20, z: 30)
        let location2 = Point3D(x: 40, y: 50, z: 60)

        let model1 = CarLocationModel(date: date, location: location1)
        let model2 = CarLocationModel(date: date, location: location2)

        #expect(model1.id == model2.id)
    }

    @Test
    func modelEqualityWithSameValues() async throws {
        let date = Date()
        let location = Point3D(x: 123, y: 456, z: 789)

        let model1 = CarLocationModel(date: date, location: location)
        let model2 = CarLocationModel(date: date, location: location)

        #expect(model1.id == model2.id)
        #expect(model1.date == model2.date)
        #expect(model1.location == model2.location)
    }

    @Test
    func createModelWithPastDate() async throws {
        let pastDate = Date(timeIntervalSince1970: 0) // January 1, 1970
        let location = Point3D(x: 50, y: 60, z: 70)

        let model = CarLocationModel(date: pastDate, location: location)

        #expect(model.date == pastDate)
        #expect(model.id == DateHelper.toIdentifier(date: pastDate))
    }

    @Test
    func createModelWithFutureDate() async throws {
        let futureDate = Date().addingTimeInterval(86400 * 365) // 1 year from now
        let location = Point3D(x: 80, y: 90, z: 100)

        let model = CarLocationModel(date: futureDate, location: location)

        #expect(model.date == futureDate)
        #expect(model.id == DateHelper.toIdentifier(date: futureDate))
    }

    @Test
    func createModelWithDecimalCoordinates() async throws {
        let date = Date()
        let location = Point3D(x: 123.456, y: 789.012, z: 345.678)

        let model = CarLocationModel(date: date, location: location)

        #expect(model.location.x == 123.456)
        #expect(model.location.y == 789.012)
        #expect(model.location.z == 345.678)
    }
}
