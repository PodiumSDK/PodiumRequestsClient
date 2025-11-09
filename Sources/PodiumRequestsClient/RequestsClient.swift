//
//  RequestsClient.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 25/09/2024.
//

import Foundation
import Alamofire

/// A client responsible for performing requests to the Podium API.
///
/// `RequestsClient` provides typed access to the API endpoints for sessions, race control,
/// cars, drivers, and related data. Each method performs network requests asynchronously
/// and decodes the responses into strongly-typed models.
public class RequestsClient {
  // MARK: - Private Properties
  private let baseURL: String
  private let apiKey: String

  // MARK: - Lifecycle
  /// Initializes a new `RequestsClient` instance with a given API base URL and authentication key.
  ///
  /// ```
  /// let client = RequestsClient(
  ///     baseURL: "<API_BASE_URL>",
  ///     apiKey: "<API_KEY>"
  /// )
  /// ```
  ///
  /// - Parameters:
  ///   - baseURL: The base URL of the API.
  ///   - apiKey: The API key used for authorization.
  public init(baseURL: String, apiKey: String) {
    self.baseURL = baseURL
    self.apiKey = apiKey
  }

  // MARK: - Private Methods
  /// Performs a request to a given endpoint, returning a decoded value.
  ///
  /// - Parameters:
  ///   - endpoint: The endpoint to request.
  ///   - type: The type of value expected in the response.
  ///   - method: The HTTP method to use (default: `.get`).
  ///   - chunk: An optional `Chunk` to filter time-based results.
  ///
  /// - Returns: A decoded instance of type `T`.
  /// - Throws: An error if the request or decoding fails.
  private func request<E, T>(
    endpoint: E,
    type: T.Type,
    method: HTTPMethod = .get,
    chunk: Chunk? = nil
  ) async throws -> T where E: PodiumEndpoint, T: Decodable, T: Sendable {
    let task: DataRequest = AF.request(
      baseURL + endpoint.path,
      method: method,
      parameters: getChunkParameters(chunk: chunk),
      encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
      headers: HTTPHeaders([
        HTTPHeader(name: "Authorization", value: "Bearer " + apiKey)
      ])
    )
    let response = await task.serializingDecodable(type, decoder: JSONDecoder.podium).response

    switch response.result {
    case .success(let data):
      return data
    case .failure(let error):
      throw error
    }
  }

  /// Converts a `Chunk` instance into Alamofire request parameters.
  ///
  /// - Parameters:
  ///   - chunk: The chunk to convert.
  /// - Returns: A dictionary of query parameters, or `nil` if no chunk is provided.
  private func getChunkParameters(chunk: Chunk?) -> Parameters? {
    guard let chunk else {
      return nil
    }

    return ["after": chunk.after, "before": chunk.before]
  }

  // MARK: - Public Methods

  /// Retrieves all available sessions.
  ///
  /// - Returns: A list of all available sessions.
  /// - Throws: An error if the request or decoding fails.
  public func getAllSessions() async throws -> [SessionModel] {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getAll,
      type: [SessionDomain].self
    )

    return domain.map { SessionMapper.map(from: $0) }
  }

  /// Retrieves a specific session by its unique key.
  ///
  /// - Parameters:
  ///   - sessionKey: The unique key identifying the session.
  /// - Returns: The session matching the given key.
  /// - Throws: An error if the session cannot be found or decoding fails.
  public func getSession(
    sessionKey: Int
  ) async throws -> SessionModel {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getOne(sessionKey: sessionKey),
      type: SessionDomain.self
    )

    return SessionMapper.map(from: domain)
  }

  /// Retrieves all race control messages for a given session.
  ///
  /// - Parameters:
  ///   - sessionKey: The key of the session to query.
  ///   - chunk: An optional `Chunk` used to limit the time range of the data.
  /// - Returns: A list of race control messages.
  /// - Throws: An error if the session cannot be found or decoding fails.
  public func getAllRaceControl(
    sessionKey: Int,
    chunk: Chunk? = nil
  ) async throws -> [RaceControlModel] {
    let domain = try await request(
      endpoint: Endpoints.RaceControl.getAll(sessionKey: sessionKey),
      type: [RaceControlDomain].self,
      chunk: chunk
    )

    return domain.map { RaceControlMapper.map(from: $0) }
  }

  /// Retrieves all cars participating in a given session.
  ///
  /// - Parameters:
  ///   - sessionKey: The key of the session to query.
  /// - Returns: A list of cars present in the session.
  /// - Throws: An error if the session cannot be found or decoding fails.
  public func getAllCars(
    sessionKey: Int
  ) async throws -> [CarModel] {
    let domain = try await request(
      endpoint: Endpoints.Cars.getAll(sessionKey: sessionKey),
      type: [CarDomain].self
    )

    return domain.map { CarMapper.map(from: $0) }
  }

  /// Retrieves all recorded locations for a given car in a session.
  ///
  /// - Parameters:
  ///   - sessionKey: The session key.
  ///   - car: The unique car identifier.
  ///   - chunk: An optional `Chunk` to filter data by time.
  /// - Returns: A list of car locations.
  /// - Throws: An error if the data cannot be fetched or decoded.
  public func getAllCarLocations(
    sessionKey: Int,
    car: Int,
    chunk: Chunk? = nil
  ) async throws -> [CarLocationModel] {
    let domain = try await request(
      endpoint: Endpoints.Cars.getLocations(sessionKey: sessionKey, driver: car),
      type: [CarLocationDomain].self,
      chunk: chunk
    )

    return domain.map { CarMapper.map(from: $0) }
  }

  /// Retrieves all telemetry data for a given car in a session.
  ///
  /// - Parameters:
  ///   - sessionKey: The session key.
  ///   - car: The unique car identifier.
  ///   - chunk: An optional `Chunk` to filter data by time.
  /// - Returns: A list of car telemetry data entries.
  /// - Throws: An error if the data cannot be fetched or decoded.
  public func getAllCarTelemetry(
    sessionKey: Int,
    car: Int,
    chunk: Chunk? = nil
  ) async throws -> [CarTelemetryModel] {
    let domain = try await request(
      endpoint: Endpoints.Cars.getData(sessionKey: sessionKey, driver: car),
      type: [CarTelemetryDomain].self,
      chunk: chunk
    )

    return domain.map { CarMapper.map(from: $0) }
  }

  /// Retrieves all drivers participating in a given session.
  ///
  /// - Parameters:
  ///   - sessionKey: The key of the session to query.
  /// - Returns: A list of drivers present in the session.
  /// - Throws: An error if the session cannot be found or decoding fails.
  public func getAllDrivers(
    sessionKey: Int
  ) async throws -> [DriverModel] {
    let domain = try await request(
      endpoint: Endpoints.Drivers.getAll(sessionKey: sessionKey),
      type: [DriverDomain].self
    )

    return domain.map { DriverMapper.map(domain: $0) }
  }

  /// Retrieves a specific driver by ID from a session.
  ///
  /// - Parameters:
  ///   - sessionKey: The key of the session to query.
  ///   - driver: The driver’s unique identifier.
  /// - Returns: The driver matching the given ID.
  /// - Throws: An error if the driver cannot be found or decoding fails.
  public func getDriver(
    sessionKey: Int,
    driver: Int
  ) async throws -> DriverModel {
    let domain = try await request(
      endpoint: Endpoints.Drivers.getOne(sessionKey: sessionKey, driver: driver),
      type: DriverDomain.self
    )

    return DriverMapper.map(domain: domain)
  }
}

extension RequestsClient {
  /// Represents a time-based range for retrieving partial data from the API.
  ///
  /// A `Chunk` allows you to specify the range of seconds to include in the request.
  /// Both `after` and `before` are optional, allowing flexible windowed queries.
  public struct Chunk {
    // MARK: - Properties
    /// The time in seconds from which to start retrieving data.
    public let after: Int?

    /// The time in seconds until which to retrieve data.
    public let before: Int?

    // MARK: - Lifecycle
    /// Initializes a new `Chunk` with optional time bounds.
    ///
    /// - Parameters:
    ///   - after: The start time (in seconds) for data retrieval.
    ///   - before: The end time (in seconds) for data retrieval.
    public init(after: Int?, before: Int?) {
      self.after = after
      self.before = before
    }
  }
}
