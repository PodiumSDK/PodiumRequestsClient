//
//  PodiumRequestsClient.swift
//  PodiumRequestsClient
//
//  Created by Mathis Le Bonniec on 25/09/2024.
//

import Foundation
import Alamofire

public class PodiumRequestsClient {
  // MARK: Private Properties
  private let baseURL: String
  private let apiKey: String

  // MARK: Lifecycle
  public init(baseURL: String, apiKey: String) {
    self.baseURL = baseURL
    self.apiKey = apiKey
  }

  // MARK: Private Methods
  private func request<E, T>(
    endpoint: E,
    type: T.Type,
    method: HTTPMethod = .get,
    chunk: PodiumRequestsChunk? = nil
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

  private func getChunkParameters(chunk: PodiumRequestsChunk?) -> Parameters? {
    guard let chunk else {
      return nil
    }

    return ["after": chunk.after, "before": chunk.before]
  }

  // MARK: Public Methods
  public func getAllSessions() async throws -> [SessionModel] {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getAll,
      type: [SessionDomain].self
    )

    return domain.map { SessionMapper.map(from: $0) }
  }

  public func getSession(
    sessionKey: Int
  ) async throws -> SessionModel {
    let domain = try await request(
      endpoint: Endpoints.Sessions.getOne(sessionKey: sessionKey),
      type: SessionDomain.self
    )

    return SessionMapper.map(from: domain)
  }

  public func getAllRaceControl(
    sessionKey: Int,
    chunk: PodiumRequestsChunk? = nil
  ) async throws -> [RaceControlModel] {
    let domain = try await request(
      endpoint: Endpoints.RaceControl.getAll(sessionKey: sessionKey),
      type: [RaceControlDomain].self,
      chunk: chunk
    )

    return domain.map { RaceControlMapper.map(from: $0) }
  }

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
    chunk: PodiumRequestsChunk? = nil
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
    chunk: PodiumRequestsChunk? = nil
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
