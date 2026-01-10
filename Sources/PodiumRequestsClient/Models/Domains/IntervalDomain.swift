//
//  IntervalDomain.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

struct IntervalDomain: Decodable {
  let date: Date
  let driver: Int
  let interval: Float?
  let leader: Float?
}
