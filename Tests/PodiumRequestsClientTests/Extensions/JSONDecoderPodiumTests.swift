//
//  JSONDecoderPodiumTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/5/25.
//

import Foundation
@testable import PodiumRequestsClient
import Testing

private struct DecodableDate: Decodable {
  let date: Date

  private enum CodingKeys: String, CodingKey {
    case date
  }
}

@Suite("JSONDecoder.podium")
struct JSONDecoderPodiumTests {
    private func date(from string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: string)
    }

    @Test("Decodes microsecond ISO8601 with timezone offset")
    func decodesMicrosecondISO8601WithTimezoneOffset() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123456+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33.123456+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))
        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes second precision ISO8601 with timezone offset")
    func decodesSecondPrecisionISO8601WithTimezoneOffset() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33+00:00", format: "yyyy-MM-dd'T'HH:mm:ssXXXXX"))
        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Throws on unsupported format")
    func throwsOnUnsupportedFormat() {
        let jsonString = #"{"date":"03/11/2025 14:22:33"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try? JSONDecoder.podium.decode(DecodableDate.self, from: data)

        #expect(decoded == nil)
    }

    @Test("Decodes millisecond ISO8601 with timezone offset")
    func decodesMillisecondISO8601WithTimezoneOffset() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33.123+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes ISO8601 with Z timezone")
    func decodesISO8601WithZTimezone() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123456Z"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33.123456+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes ISO8601 with non-zero timezone offset")
    func decodesISO8601WithNonZeroTimezoneOffset() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123+05:30"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33.123+05:30", format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes ISO8601 with negative timezone offset")
    func decodesISO8601WithNegativeTimezoneOffset() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123-07:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-11-03T14:22:33.123-07:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes midnight date")
    func decodesMidnightDate() throws {
        let jsonString = #"{"date":"2025-01-01T00:00:00.000000+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-01-01T00:00:00.000000+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes end of day date")
    func decodesEndOfDayDate() throws {
        let jsonString = #"{"date":"2025-12-31T23:59:59.999999+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-12-31T23:59:59.999999+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes leap year date")
    func decodesLeapYearDate() throws {
        let jsonString = #"{"date":"2024-02-29T12:00:00.000000+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2024-02-29T12:00:00.000000+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }

    @Test("Decodes nanosecond precision if supported")
    func decodesNanosecondPrecision() throws {
        let jsonString = #"{"date":"2025-11-03T14:22:33.123456789+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)

        #expect(decoded.date.timeIntervalSince1970 > 0)
    }

    @Test("Throws on invalid date format")
    func throwsOnInvalidDateFormat() {
        let jsonString = #"{"date":"2025-13-45T14:22:33+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try? JSONDecoder.podium.decode(DecodableDate.self, from: data)

        #expect(decoded == nil)
    }

    @Test("Throws on malformed JSON")
    func throwsOnMalformedJSON() {
        let jsonString = #"{"date":"2025-11-03T14:22:33+00:00""#
        let data = jsonString.data(using: .utf8)!
        let decoded = try? JSONDecoder.podium.decode(DecodableDate.self, from: data)

        #expect(decoded == nil)
    }

    @Test("Throws on non-string date value")
    func throwsOnNonStringDateValue() {
        let jsonString = #"{"date":1730642553}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try? JSONDecoder.podium.decode(DecodableDate.self, from: data)

        #expect(decoded == nil)
    }

    @Test("Decodes single digit month and day")
    func decodesSingleDigitMonthAndDay() throws {
        let jsonString = #"{"date":"2025-01-05T09:08:07.123456+00:00"}"#
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder.podium.decode(DecodableDate.self, from: data)
        let expectedDate = try #require(date(from: "2025-01-05T09:08:07.123456+00:00", format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"))

        #expect(abs(decoded.date.timeIntervalSince1970 - expectedDate.timeIntervalSince1970) < 0.001)
    }
}
