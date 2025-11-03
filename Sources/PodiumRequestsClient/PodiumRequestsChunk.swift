//
//  PodiumRequestsChunk.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/3/25.
//

import Foundation

public struct PodiumRequestsChunk {
  // MARK: Properties
  public let after: Int?
  public let before: Int?

  // MARK: Lifecycle
  public init(after: Int?, before: Int?) {
    self.after = after
    self.before = before
  }
}
