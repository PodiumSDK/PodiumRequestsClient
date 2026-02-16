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

    @Test
    func chunkWithZeroValues() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: 0,
            before: 0
        )

        #expect(chunk.after == 0)
        #expect(chunk.before == 0)
    }

    @Test
    func chunkWithLargeValues() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: 10000,
            before: 50000
        )

        #expect(chunk.after == 10000)
        #expect(chunk.before == 50000)
    }

    @Test
    func chunkWithSameAfterAndBefore() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: 250,
            before: 250
        )

        #expect(chunk.after == 250)
        #expect(chunk.before == 250)
    }

    @Test
    func chunkWithAfterGreaterThanBefore() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: 500,
            before: 100
        )

        // Should still create the chunk (validation may happen elsewhere)
        #expect(chunk.after == 500)
        #expect(chunk.before == 100)
    }

    @Test
    func chunkRangeIsValid() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: 100,
            before: 500
        )

        let range = (chunk.before ?? 0) - (chunk.after ?? 0)
        #expect(range == 400)
    }

    @Test
    func multipleChunksWithDifferentRanges() async throws {
        let chunk1: RequestsClient.Chunk = RequestsClient.Chunk(after: 0, before: 100)
        let chunk2: RequestsClient.Chunk = RequestsClient.Chunk(after: 100, before: 200)
        let chunk3: RequestsClient.Chunk = RequestsClient.Chunk(after: 200, before: 300)

        #expect(chunk1.after != chunk2.after)
        #expect(chunk1.before == chunk2.after)
        #expect(chunk2.before == chunk3.after)
    }

    @Test
    func chunkWithNegativeValues() async throws {
        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: -100,
            before: -50
        )

        #expect(chunk.after == -100)
        #expect(chunk.before == -50)
    }

    @Test
    func chunkEquality() async throws {
        let chunk1: RequestsClient.Chunk = RequestsClient.Chunk(after: 150, before: 200)
        let chunk2: RequestsClient.Chunk = RequestsClient.Chunk(after: 150, before: 200)

        #expect(chunk1.after == chunk2.after)
        #expect(chunk1.before == chunk2.before)
    }

    @Test
    func chunkWithMixedNilValues() async throws {
        let chunk1: RequestsClient.Chunk = RequestsClient.Chunk(after: 100, before: nil)
        let chunk2: RequestsClient.Chunk = RequestsClient.Chunk(after: nil, before: 200)

        #expect(chunk1.after != nil)
        #expect(chunk1.before == nil)
        #expect(chunk2.after == nil)
        #expect(chunk2.before != nil)
    }

    @Test
    func chunkCreationWithOptionals() async throws {
        let after: Int? = 50
        let before: Int? = 150

        let chunk: RequestsClient.Chunk = RequestsClient.Chunk(
            after: after,
            before: before
        )

        #expect(chunk.after == 50)
        #expect(chunk.before == 150)
    }
}
