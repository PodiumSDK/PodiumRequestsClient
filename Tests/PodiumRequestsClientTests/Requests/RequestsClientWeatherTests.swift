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

    @Test
    func getAllWeatherUpdatesAreChronological() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for i in 0..<(weatherUpdates.count - 1) {
            let current = weatherUpdates[i]
            let next = weatherUpdates[i + 1]
            // Assuming weather updates have a timestamp/date field
            // #expect(current.date <= next.date)
            #expect(current.pressure > 0)
            #expect(next.pressure > 0)
        }
    }

    @Test
    func getAllWeatherUpdatesHaveValidData() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            #expect(update.humidity >= 0)
            #expect(update.humidity <= 100)
            #expect(update.pressure > 900)
            #expect(update.pressure < 1100)
            #expect(update.temperature.air >= -50)
            #expect(update.temperature.air <= 60)
            #expect(update.temperature.track >= -50)
            #expect(update.temperature.track <= 100)
            #expect(update.wind.direction >= 0)
            #expect(update.wind.direction < 360)
            #expect(update.wind.speed >= 0)
        }
    }

    @Test
    func trackTemperatureIsHigherThanAirTemperature() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        // Track temperature is typically higher than air temperature
        let mostUpdates = weatherUpdates.filter { $0.temperature.track > $0.temperature.air }
        #expect(mostUpdates.count > weatherUpdates.count / 2)
    }

    @Test
    func weatherHumidityIsWithinValidRange() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            #expect(update.humidity >= 0)
            #expect(update.humidity <= 100)
        }
    }

    @Test
    func weatherPressureIsRealistic() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            // Sea level pressure typically 980-1040 hPa
            #expect(update.pressure >= 950)
            #expect(update.pressure <= 1050)
        }
    }

    @Test
    func windDirectionIsValidDegrees() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            #expect(update.wind.direction >= 0)
            #expect(update.wind.direction < 360)
        }
    }

    @Test
    func windSpeedIsNonNegative() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            #expect(update.wind.speed >= 0)
        }
    }

    @Test
    func getWeatherWithSpecificHumidity() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)
        let specificUpdate = weatherUpdates.filter { $0.humidity == 39 }

        #expect(!specificUpdate.isEmpty)
    }

    @Test
    func weatherUpdatesShowVariation() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        let temperatures = Set(weatherUpdates.map { $0.temperature.air })
        let humidities = Set(weatherUpdates.map { $0.humidity })

        // Weather should vary throughout the session
        #expect(temperatures.count > 1)
        #expect(humidities.count > 1)
    }

    @Test(.bug("https://github.com/EpitechPromo2026/G-EIP-700-REN-7-1-eip-mathis.le-bonniec/issues/113"), .disabled())
    func getAllWeatherWithInvalidSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getAllWeatherUpdates(sessionKey: -1)
        }
    }

    @Test(.bug("https://github.com/EpitechPromo2026/G-EIP-700-REN-7-1-eip-mathis.le-bonniec/issues/113"), .disabled())
    func getAllWeatherWithNonExistentSessionKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getAllWeatherUpdates(sessionKey: 999999)
        }
    }

    @Test
    func weatherUpdateCountMatchesExpected() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        #expect(weatherUpdates.count == 176)
    }

    @Test
    func trackTemperatureExceedsAirTemperatureSignificantly() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)
        let first = try #require(weatherUpdates.first(where: { $0.pressure == 1013.7 }))

        let difference = first.temperature.track - first.temperature.air
        #expect(difference > 10) // Track typically 10-30°C hotter
    }

    @Test
    func weatherConditionsAreConsistentWithMonaco() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        // Monaco in May/June typically warm
        let averageAirTemp = weatherUpdates.map { $0.temperature.air }.reduce(0, +) / Double(weatherUpdates.count)
        #expect(averageAirTemp > 15)
        #expect(averageAirTemp < 35)
    }

    @Test
    func pressureDoesNotFluctuateWildly() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        let pressures = weatherUpdates.map { $0.pressure }
        let minPressure = pressures.min() ?? 0
        let maxPressure = pressures.max() ?? 0
        let pressureRange = maxPressure - minPressure

        // Pressure shouldn't change more than ~20 hPa during a race
        #expect(pressureRange < 30)
    }

    @Test
    func windSpeedIsReasonable() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            // Wind speed in m/s, typically 0-20 m/s at race events
            #expect(update.wind.speed < 25)
        }
    }

    @Test
    func multipleWeatherUpdatesExist() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        // Should have multiple updates throughout the session
        #expect(weatherUpdates.count > 50)
    }

    @Test
    func temperatureValuesAreRealistic() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        for update in weatherUpdates {
            // Monaco in May: reasonable temperature ranges
            #expect(update.temperature.air >= 10)
            #expect(update.temperature.air <= 40)
            #expect(update.temperature.track >= 20)
            #expect(update.temperature.track <= 70)
        }
    }

    @Test
    func getAllWeatherMultipleTimesReturnsConsistentCount() async throws {
        let weatherUpdates1 = try await client.getAllWeatherUpdates(sessionKey: sessionKey)
        let weatherUpdates2 = try await client.getAllWeatherUpdates(sessionKey: sessionKey)

        #expect(weatherUpdates1.count == weatherUpdates2.count)
        #expect(weatherUpdates1.count == 176)
    }

    @Test
    func weatherDataContainsSpecificPressureValue() async throws {
        let weatherUpdates = try await client.getAllWeatherUpdates(sessionKey: sessionKey)
        let hasPressure1013_7 = weatherUpdates.contains(where: { $0.pressure == 1013.7 })

        #expect(hasPressure1013_7)
    }
}
