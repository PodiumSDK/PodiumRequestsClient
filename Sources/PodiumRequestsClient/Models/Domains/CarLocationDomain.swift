//
//  CarLocationDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 10/28/24.
//

import Foundation

struct CarLocationDomain: Decodable {
  let date: Date
  let number: Int
  let key: Int
  let x: Double
  let y: Double
  let z: Double
}
