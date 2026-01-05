//
//  Endpoints+Intervale.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

extension Endpoints {
    enum Interval {
        /// Get all interval updates for a specific session.
        /// - Parameters:
        ///   - sessionKey The unique session key to get all the interval updates.
        case getAll(sessionKey: Int)
    }
}

extension Endpoints.Interval: PodiumEndpoint {
    var path: String {
        switch self {
        case .getAll(let sessionKey):
            "/sessions/\(sessionKey)/intervals"
        }
    }
}
