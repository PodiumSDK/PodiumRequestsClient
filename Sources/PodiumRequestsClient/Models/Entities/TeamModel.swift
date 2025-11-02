//
//  TeamModel.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 6/13/25.
//

import Foundation
import SwiftUI

public struct TeamModel: Identifiable {
  // MARK: Properties
  /// The team unique identifier, which is here the team name.
  public var id: String {
    name
  }

  /// The team name.
  public let name: String

  /// The team color..
  public let color: Color

  /// The team logo image URL.
  public let image: URL?
}
