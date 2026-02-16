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

    @Test
    func midnightDate() async throws {
        let date: Date = try Date("2020-06-15T00:00:00Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "2020-06-15T00:00:00.000Z")
    }

    @Test
    func endOfDayDate() async throws {
        let date: Date = try Date("2021-08-20T23:59:59Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "2021-08-20T23:59:59.000Z")
    }

    @Test
    func epochDate() async throws {
        let date = Date(timeIntervalSince1970: 0)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "1970-01-01T00:00:00.000Z")
    }

    @Test
    func leapYearDate() async throws {
        let date: Date = try Date("2024-02-29T14:30:00Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "2024-02-29T14:30:00.000Z")
    }

    @Test
    func currentDateFormat() async throws {
        let date = Date()
        let identifier: String = DateHelper.toIdentifier(date: date)

        // Verify format structure
        #expect(identifier.contains("T"))
        #expect(identifier.hasSuffix("Z"))
        #expect(identifier.contains("."))
    }

    @Test
    func differentDatesHaveDifferentIdentifiers() async throws {
        let date1: Date = try Date("2022-01-01T10:00:00Z", strategy: .iso8601)
        let date2: Date = try Date("2022-01-01T10:00:01Z", strategy: .iso8601)

        let identifier1 = DateHelper.toIdentifier(date: date1)
        let identifier2 = DateHelper.toIdentifier(date: date2)

        #expect(identifier1 != identifier2)
    }

    @Test
    func sameDateHasSameIdentifier() async throws {
        let date: Date = try Date("2023-07-04T16:45:30Z", strategy: .iso8601)

        let identifier1 = DateHelper.toIdentifier(date: date)
        let identifier2 = DateHelper.toIdentifier(date: date)

        #expect(identifier1 == identifier2)
    }

    @Test
    func identifierLengthConsistency() async throws {
        let dates = [
            try Date("2000-01-01T00:00:00Z", strategy: .iso8601),
            try Date("2015-06-15T12:30:45Z", strategy: .iso8601),
            try Date("2025-12-31T23:59:59Z", strategy: .iso8601)
        ]

        let identifiers = dates.map { DateHelper.toIdentifier(date: $0) }
        let lengths = Set(identifiers.map { $0.count })

        // All identifiers should have the same length
        #expect(lengths.count == 1)
    }

    @Test
    func identifierAlwaysHasThreeDecimalPlaces() async throws {
        let date: Date = try Date("2023-05-10T08:15:22Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        // Extract fractional seconds part
        let components = identifier.split(separator: ".")
        #expect(components.count == 2)

        let fractionalPart = String(components[1].dropLast()) // Remove 'Z'
        #expect(fractionalPart.count == 3)
    }

    @Test
    func veryOldDate() async throws {
        let date: Date = try Date("1900-01-01T00:00:00Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "1900-01-01T00:00:00.000Z")
    }

    @Test
    func farFutureDate() async throws {
        let date: Date = try Date("2099-12-31T23:59:59Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        #expect(identifier == "2099-12-31T23:59:59.000Z")
    }

    @Test
    func singleDigitMonthAndDay() async throws {
        let date: Date = try Date("2023-01-05T09:08:07Z", strategy: .iso8601)
        let identifier: String = DateHelper.toIdentifier(date: date)

        // Should have zero-padding
        #expect(identifier.contains("-01-"))
        #expect(identifier.contains("-05T"))
    }

    @Test
    func identifierSortability() async throws {
        let date1: Date = try Date("2020-05-10T10:00:00Z", strategy: .iso8601)
        let date2: Date = try Date("2021-03-15T14:30:00Z", strategy: .iso8601)
        let date3: Date = try Date("2022-11-20T08:45:00Z", strategy: .iso8601)

        let id1 = DateHelper.toIdentifier(date: date1)
        let id2 = DateHelper.toIdentifier(date: date2)
        let id3 = DateHelper.toIdentifier(date: date3)

        // Identifiers should be lexicographically sortable
        #expect(id1 < id2)
        #expect(id2 < id3)
        #expect(id1 < id3)
    }
}
