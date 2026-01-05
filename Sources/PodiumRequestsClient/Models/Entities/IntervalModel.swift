//
//  IntervalModel.swift
//  PodiumRequestsClient
//
//  Created by Raphael Lecoq on 1/5/26.
//

import Foundation

public struct IntervalModel: Equatable {
  let date: Date
  let driver: Int
  let interval: Float
  let leader: Float
  
  public init(date: Date, driver: Int, interval: Float, leader: Float) {
    self.date = date
    self.driver = driver
    self.interval = interval
    self.leader = leader
  }
}
