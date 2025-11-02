//
//  PodiumRequestsClientSessionsTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation
import PodiumRequestsClient
import Testing

@Suite(.tags(.sessions))
struct PodiumRequestsClientSessionsTests {
  let sessionKey: Int = 9094
  let client: PodiumRequestsClient = PodiumRequestsClient(
    baseURL: "https://api.podium.mathislebonniec.fr/v1/formula1",
    apiKey: "08fe5ccd-8d72-49e0-ae2b-3f097f2b96a1"
  )

  @Test
  func getAllSessions() async throws {
    let sessions = try await client.getAllSessions()

    #expect(!sessions.isEmpty)
  }

  @Test
  func getSession() async throws {
    let session = try await client.getSession(sessionKey: sessionKey)

    #expect(session.key == sessionKey)
    #expect(session.name == "Race")
    #expect(session.location == "Monaco")
    #expect(session.start == Date(timeIntervalSince1970: 1685278800))
    #expect(session.end == Date(timeIntervalSince1970: 1685286000))
  }
}
