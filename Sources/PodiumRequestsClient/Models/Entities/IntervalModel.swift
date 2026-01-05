//
//  IntervalModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

struct IntervalModel: Equatable {
  let date: Date
  let driver: Int
  let interval: Float
  let leader: Float
}
