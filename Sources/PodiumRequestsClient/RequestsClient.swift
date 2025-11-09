//
//  RequestsClient.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 25/09/2024.
//

import Foundation
import Alamofire

public class RequestsClient {
  // MARK: Private Properties
  private let baseURL: String
  private let apiKey: String

  // MARK: Lifecycle
  /// Initialize a new `RequestsClient` instance by providing the API
  /// base URL and authentication key.
  ///
  /// ```
  ///  let client: RequestsClient = RequestsClient(
  ///      baseURL: "<API_BASE_URL>",
  ///      apiKey: "<API_KEY>"
  ///  )
  /// ```
  public init(baseURL: String, apiKey: String) {
    self.baseURL = baseURL
    self.apiKey = apiKey
  }

  // MARK: Private Methods
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

  private func getChunkParameters(chunk: Chunk?) -> Parameters? {
    guard let chunk else {
      return nil
    }

    return ["after": chunk.after, "before": chunk.before]
  }

  // MARK: Public Methods
  /// Get all sessions.
  ///
  /// - Returns: A list of all the available sessions.
  public func getAllSessions() async throws -> [SessionModel] {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getAll,
      type: [SessionDomain].self
    )

    return domain.map { SessionMapper.map(from: $0) }
  }

  /// Get a specific session from a given key.
  ///
  /// - Parameters:
  ///   - sessionKey: A unique session key.
  ///
  /// - Throws: If the session cannot be found.
  /// - Returns: The session.
  public func getSession(
    sessionKey: Int
  ) async throws -> SessionModel {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getOne(sessionKey: sessionKey),
      type: SessionDomain.self
    )

    return SessionMapper.map(from: domain)
  }

  /// Get all the race control messages for a session.
  ///
  /// - Parameters:
  ///   - sessionKey: The session from where to get all the race control messages.
  ///   - chunk: An optional chunk used to narrow the search.
  ///
  /// - Throws: If the session cannot be found.
  /// - Returns: A list of race control messages.
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

  /// Get all the car for a session.
  ///
  /// - Parameters:
  ///   - sessionKey: The session from where to get all the cars.
  ///
  /// - Throws: If the session cannot be found.
  /// - Returns: A list of all the cars present during the session.
  public func getAllCars(
    sessionKey: Int
  ) async throws -> [CarModel] {
    let domain = try await request(
      endpoint: Endpoints.Cars.getAll(sessionKey: sessionKey),
      type: [CarDomain].self
    )

    return domain.map { CarMapper.map(from: $0) }
  }

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

  public func getAllCarData(
    sessionKey: Int,
    car: Int,
    chunk: Chunk? = nil
  ) async throws -> [CarDataModel] {
    let domain = try await request(
      endpoint: Endpoints.Cars.getData(sessionKey: sessionKey, driver: car),
      type: [CarDataDomain].self,
      chunk: chunk
    )

    return domain.map { CarMapper.map(from: $0) }
  }

  public func getAllDrivers(
    sessionKey: Int
  ) async throws -> [DriverModel] {
    let domain = try await request(
      endpoint: Endpoints.Drivers.getAll(sessionKey: sessionKey),
      type: [DriverDomain].self
    )

    return domain.map { DriverMapper.map(domain: $0) }
  }

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
  /// Represents a chunk of data.
  public struct Chunk {
    // MARK: Properties
    /// The seconds count from where to start retrieving the data.
    public let after: Int?

    /// The seconds count from where to stop retrieving the data.
    public let before: Int?

    // MARK: Lifecycle
    public init(after: Int?, before: Int?) {
      self.after = after
      self.before = before
    }
  }
}
