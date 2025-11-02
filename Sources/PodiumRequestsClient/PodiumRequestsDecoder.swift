//
//  PodiumRequestsDecoder.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation

extension JSONDecoder {
  static var podium: JSONDecoder {
    let decoder = JSONDecoder()

    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)

      let formats: [String] = [
        "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX",
        "yyyy-MM-dd'T'HH:mm:ssXXXXX"
      ]

      let dateFormatter = DateFormatter()
      dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

      for format in formats {
        dateFormatter.dateFormat = format

        if let date = dateFormatter.date(from: dateString) {
          return date
        }
      }

      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Date string does not match any expected format."
      )
    }

    return decoder
  }
}
