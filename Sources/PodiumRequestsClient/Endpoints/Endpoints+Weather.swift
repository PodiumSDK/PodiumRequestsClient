//
//  Endpoints+Weather.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 12/21/25.
//

import Foundation

extension Endpoints {
    enum Weather {
        /// Get all weather updates for a specific session.
        /// - Parameters:
        ///   - sessionKey The unique session key to get all the weather updates.
        case getAll(sessionKey: Int)
    }
}
