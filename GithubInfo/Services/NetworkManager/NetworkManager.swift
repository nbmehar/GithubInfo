//
//  NetworkManager.swift
//  play
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation

class NetworkManager: ObservableObject {
  
    static let shared = NetworkManager()
  
    private func logRequest(request: URLRequest) {
        print("Request:" + (request.url?.description ?? ""))
        if request.allHTTPHeaderFields != nil {
            print(request.allHTTPHeaderFields ?? "")
        }

        if request.httpBody == nil {
            return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: request.httpBody!)
            print("Body:")
            print(json)
        } catch {}

        print("---------")
    }

    private func logResponse(response: HTTPURLResponse, data: Data) {
        print("---------")
        print("Response | " + (response.url?.description ?? "") + " : " + String(response.statusCode))

        do {
            let json = try JSONSerialization.jsonObject(with: data)
            print("Body:")
            print(json)
        } catch {}

        print("---------")
    }

  func get(path: String) async throws -> Result<Data, APIError> {
      guard let apiUrl = URL(string: path) else {
          return .failure(.invalidURL)
      }

      var request = URLRequest(url: apiUrl)
      request.httpMethod = "GET"
      logRequest(request: request)
    
      do {
          let (data, response) = try await URLSession.shared.data(for: request)
          
          if let httpResponse = response as? HTTPURLResponse {
              logResponse(response: httpResponse, data: data)
          }
          
          return .success(data)
      } catch {
          return .failure(APIError.unknown(nil))
      }
  }
}


extension Result {
    func decodeAPIResult<T: Codable>(_: T.Type)  -> Result<T, APIError> {
        switch self {
        case let .success(success):
            let data = success
            do {
                return try .success(JSONDecoder().decode(T.self, from: data as! Data))
            } catch let e {
                print("Decode Error:")
                print(T.self)
                print(e)
                return .failure(APIError.jsonDecodingError(error: e))
            }
        case let .failure(failure):
            return .failure(failure as! APIError)
        }
    }
}
