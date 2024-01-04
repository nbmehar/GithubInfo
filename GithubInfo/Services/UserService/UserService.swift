//
//  UserService.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 04/01/24.
//

import Foundation

class UserService{
  
  let networkManager: NetworkManager
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
  
  func getUserDetails(username: String) async -> Result<UserDetailsModel, APIError> {
    do {
        let result = try await networkManager.get(path: EndPoints.apiBaseUrl + EndPoints.getUserDetails + username)
        return result.decodeAPIResult(UserDetailsModel.self)
    } catch let e {
        return .failure(APIError.unknown(e))
    }
  }
  
  func getConnections(username: String, connectionType: String) async -> Result<UserDetailsModelList, APIError> {
    do {
        let result = try await networkManager.get(path: EndPoints.apiBaseUrl + EndPoints.getUserDetails + username + "/" + connectionType )
        return result.decodeAPIResult(UserDetailsModelList.self)
    } catch let e {
        return .failure(APIError.unknown(e))
    }
  }
  
  
}
