//
//  RequestsClientWeatherTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 12/21/25.
//

import PodiumRequestsClient
import Testing

@Suite(.tags(.weather))
struct RequestsClientWeatherTests {
    let sessionKey: Int = 9094
    let client: RequestsClient = RequestsClient(
        baseURL: "https://api.podium.mathislebonniec.fr/v1/formula1",
        apiKey: "08fe5ccd-8d72-49e0-ae2b-3f097f2b96a1"
    )

    @Test
    func getAllWeather() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        #expect(weatherUpdates.count == 176)
    }

    @Test
    func getOneWeather() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)
        let first = try #require(weatherUpdates.first(where: { $0.pressure == 1013.7 }))

        #expect(first.humidity == 39)
        #expect(first.pressure == 1013.7)
        #expect(first.temperature.track == 47.4)
        #expect(first.temperature.air == 25.8)
        #expect(first.wind.direction == 149)
        #expect(first.wind.speed == 1)
    }
}
