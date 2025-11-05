//
//  PodiumRequestsChunkTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/5/25.
//

@testable import PodiumRequestsClient
import Testing

@Suite
struct PodiumRequestsChunkTests {
  @Test
  func beforeAndAfterNonNil() async throws {
    let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
      after: 150,
      before: 200
    )

    #expect(chunk.after == 150)
    #expect(chunk.before == 200)
  }

  @Test
  func afterParameterNil() async throws {
    let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
      after: nil,
      before: 499
    )

    #expect(chunk.after == nil)
    #expect(chunk.before == 499)
  }

  @Test
  func beforeParameterNil() async throws {
    let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
      after: 0,
      before: nil
    )

    #expect(chunk.after == 0)
    #expect(chunk.before == nil)
  }

  @Test
  func beforeAndAfterParametersNil() async throws {
    let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
      after: nil,
      before: nil
    )

    #expect(chunk.after == nil)
    #expect(chunk.before == nil)
  }
}
