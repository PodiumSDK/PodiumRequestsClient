//
//  TeamModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/13/25.
//

import Foundation
import SwiftUI

struct TeamModel: Identifiable {
  // MARK: Properties
  /// The team unique identifier, which is here the team name.
  var id: String {
    name
  }

  /// The team name.
  let name: String

  /// The team color..
  let color: Color

  /// The team logo image URL.
  let image: URL?
}
