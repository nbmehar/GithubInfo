//
//  UserViewModel.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 04/01/24.
//

import SwiftUI

class UserViewModel: BaseViewModel {
  
  let userService: UserService
  var userDetails: UserDetailsModel?
  var connections: [UserDetailsModel]
  var selectedConnectionType: String

  init(userService: UserService ) {
      self.userService = userService
      connections = []
    selectedConnectionType = String.StringKey.followers.rawValue
  }
  
  func getUserDetails(username: String) async{
      setLoading()
    let result = await userService.getUserDetails(username: username)
      handleResult(result) { response in
        self.userDetails = response
      }
  }
  
  func getConnections(username: String) async{
    setLoading()
    let result = await userService.getConnections(username: username, connectionType: selectedConnectionType)
      handleResult(result) { response in
          self.connections = response
      }
  }
  
  
  
  
}
