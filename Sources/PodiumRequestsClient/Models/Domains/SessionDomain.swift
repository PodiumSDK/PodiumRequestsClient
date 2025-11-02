//
//  SessionDomain.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 10/28/24.
//

import Foundation

struct SessionTimeDomain: Decodable {
  let start: Date
  let end: Date
}

struct SessionDomain: Decodable {
  let time: SessionTimeDomain
  let location: String
  let meeting: Int
  let key: Int
  let name: String
  let type: String
}
