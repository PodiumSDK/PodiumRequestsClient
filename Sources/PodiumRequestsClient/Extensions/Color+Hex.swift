//
//  Color+Hex.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 3/5/25.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let chars: [Character] = hex.starts(with: "#") ? Array(hex.dropFirst()) : Array(hex)
    guard chars.count == 6 else {
      self = .clear
      return
    }

    self.init(
      red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
      green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
      blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255
    )
  }
}
