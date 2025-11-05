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
}

