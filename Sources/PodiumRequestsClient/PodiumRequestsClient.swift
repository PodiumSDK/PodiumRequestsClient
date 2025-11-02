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
  init(baseURL: String, apiKey: String) {
    self.baseURL = baseURL
    self.apiKey = apiKey
  }

  // MARK: Public Methods
  func request<E, T>(
    endpoint: E,
    type: T.Type,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil
  ) async throws -> T where E: PodiumEndpoint, T: Decodable, T: Sendable {
    let task: DataRequest = AF.request(
      baseURL + endpoint.path,
      method: method,
      parameters: parameters,
      encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
      headers: HTTPHeaders([
        HTTPHeader(name: "Authorization", value: "Bearer \(apiKey)")
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
}
