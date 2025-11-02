//
//  DateHelper.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/26/25.
//

import Foundation

enum DateHelper {
  /// Convert a date into a string identifier.
  /// The date is formatted to an ISO 8601 format.
  /// - Note: The fractional seconds are included.
  static func toIdentifier(date: Date) -> String {
    let style: Date.ISO8601FormatStyle = .iso8601WithTimeZone(includingFractionalSeconds: true)

    return date.ISO8601Format(style)
  }
}
