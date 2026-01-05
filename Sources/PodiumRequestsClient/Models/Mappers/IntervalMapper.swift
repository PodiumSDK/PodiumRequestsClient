//
//  IntervalMapper.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

enum IntervalMapper {
    /// Maps an `IntervalDomain` instance to an `IntervalModel` instance.
    ///
    /// - Parameter domain: The domain model representing interval data to map from.
    /// - Returns: An `IntervalModel` created from the given domain model, with all relevant properties converted accordingly.
    static func map(from domain: IntervalDomain) -> IntervalModel {
        IntervalModel(
            date: domain.date,
            driver: domain.driver,
            interval: domain.interval,
            leader: domain.leader
        )
    }
}
