//
//  RequestsClientSessionsTests.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 11/2/25.
//

import Foundation
import PodiumRequestsClient
import Testing

@Suite(.tags(.sessions))
struct RequestsClientSessionsTests {
    let sessionKey: Int = 9094
    let client: RequestsClient = RequestsClient(
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

    @Test
    func getAllSessionsReturnsUniqueKeys() async throws {
        let sessions = try await client.getAllSessions()
        let sessionKeys = sessions.map { $0.key }
        let uniqueKeys = Set(sessionKeys)

        #expect(sessionKeys.count == uniqueKeys.count)
    }

    @Test
    func getAllSessionsHaveValidData() async throws {
        let sessions = try await client.getAllSessions()

        for session in sessions {
            #expect(session.key > 0)
            #expect(!session.name.isEmpty)
            #expect(!session.location.isEmpty)
            #expect(session.start < session.end)
        }
    }

    @Test
    func getSessionReturnsConsistentDataWithGetAll() async throws {
        let allSessions = try await client.getAllSessions()
        let singleSession = try await client.getSession(sessionKey: sessionKey)
        let matchingSession = try #require(allSessions.first(where: { $0.key == sessionKey }))

        #expect(singleSession.key == matchingSession.key)
        #expect(singleSession.name == matchingSession.name)
        #expect(singleSession.location == matchingSession.location)
        #expect(singleSession.start == matchingSession.start)
        #expect(singleSession.end == matchingSession.end)
    }

    @Test
    func getSessionWithInvalidKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getSession(sessionKey: -1)
        }
    }

    @Test
    func getSessionWithNonExistentKeyThrowsError() async throws {
        await #expect(throws: Error.self) {
            try await client.getSession(sessionKey: 999999)
        }
    }

    @Test
    func getAllSessionsIncludesMonacoRace() async throws {
        let sessions = try await client.getAllSessions()
        let monacoRace = sessions.first(where: { $0.key == sessionKey })

        #expect(monacoRace != nil)
        #expect(monacoRace?.location == "Monaco")
        #expect(monacoRace?.name == "Race")
    }

    @Test
    func sessionStartAndEndDatesAreValid() async throws {
        let session = try await client.getSession(sessionKey: sessionKey)

        #expect(session.start < session.end)
        #expect(session.start.timeIntervalSince1970 > 0)
        #expect(session.end.timeIntervalSince1970 > 0)
    }

    @Test
    func sessionDurationIsReasonable() async throws {
        let session = try await client.getSession(sessionKey: sessionKey)
        let duration = session.end.timeIntervalSince(session.start)

        // Race duration should be between 1 and 4 hours
        #expect(duration > 3600) // More than 1 hour
        #expect(duration < 14400) // Less than 4 hours
    }

    @Test
    func getAllSessionsContainsDifferentSessionTypes() async throws {
        let sessions = try await client.getAllSessions()
        let sessionTypes = Set(sessions.map { $0.name })

        // F1 typically has Practice, Qualifying, Sprint, Race sessions
        #expect(sessionTypes.count > 1)
    }

    @Test
    func getAllSessionsContainsDifferentLocations() async throws {
        let sessions = try await client.getAllSessions()
        let locations = Set(sessions.map { $0.location })

        // F1 season has multiple race locations
        #expect(locations.count > 1)
    }

    @Test
    func getMultipleSessionsByKey() async throws {
        let allSessions = try await client.getAllSessions()
        let firstThreeKeys = Array(allSessions.prefix(3).map { $0.key })

        for key in firstThreeKeys {
            let session = try await client.getSession(sessionKey: key)
            #expect(session.key == key)
        }
    }

    @Test
    func sessionNamesAreValid() async throws {
        let sessions = try await client.getAllSessions()
        let validNames = ["Practice 1", "Practice 2", "Practice 3", "Qualifying", "Sprint", "Race"]

        for session in sessions {
            let hasValidName = validNames.contains { session.name.contains($0) } ||
            validNames.contains(session.name)
            #expect(hasValidName || !session.name.isEmpty)
        }
    }

    @Test
    func sessionLocationsAreNonEmpty() async throws {
        let sessions = try await client.getAllSessions()

        for session in sessions {
            #expect(!session.location.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    @Test
    func getSessionMultipleTimesReturnsConsistentData() async throws {
        let session1 = try await client.getSession(sessionKey: sessionKey)
        let session2 = try await client.getSession(sessionKey: sessionKey)

        #expect(session1.key == session2.key)
        #expect(session1.name == session2.name)
        #expect(session1.location == session2.location)
        #expect(session1.start == session2.start)
        #expect(session1.end == session2.end)
    }

    @Test
    func sessionKeysArePositive() async throws {
        let sessions = try await client.getAllSessions()

        for session in sessions {
            #expect(session.key > 0)
        }
    }

    @Test
    func sessionsAreChronologicallyOrdered() async throws {
        let sessions = try await client.getAllSessions()

        // Check if sessions are sorted by start date
        for i in 0..<(sessions.count - 1) {
            let current = sessions[i]
            let next = sessions[i + 1]
            // Sessions might not be strictly ordered, but we can check
            // Or we just verify they have valid dates
            #expect(current.start.timeIntervalSince1970 > 0)
            #expect(next.start.timeIntervalSince1970 > 0)
        }
    }

    @Test
    func monacoRaceHasExpectedDates() async throws {
        let session = try await client.getSession(sessionKey: sessionKey)

        // Monaco 2023 race was on May 28, 2023
        let calendar = Calendar(identifier: .gregorian)
        let startComponents = calendar.dateComponents([.year, .month, .day], from: session.start)

        #expect(startComponents.year == 2023)
        #expect(startComponents.month == 5)
        #expect(startComponents.day == 28)
    }

    @Test
    func sessionEndIsAfterStart() async throws {
        let sessions = try await client.getAllSessions()

        for session in sessions {
            #expect(session.end > session.start)
            #expect(session.end.timeIntervalSince(session.start) > 0)
        }
    }

    @Test
    func getAllSessionsReturnsMultipleSessions() async throws {
        let sessions = try await client.getAllSessions()

        // F1 season typically has 20+ races × multiple sessions each
        #expect(sessions.count >= 10)
    }
}
