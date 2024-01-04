//
//  GithubInfoApp.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import SwiftUI

@main
struct GithubInfoApp: App {
  
  let di: DependencyInjector = .init()
  @ObservedObject var router: Router
  init() {
      router = di.router
      router.navigate(to: .search)
  }
  
    var body: some Scene {
        WindowGroup {
          ZStack{
            Color.black
            NavigationStack(path: $router.navPath) {
              Home()
                .navigationDestination(for: Router.Destination.self){ destination in
                  switch destination {
                  case .search:
                    SearchView()
                  case let .userDetails(username):
                    UserDetailsView(username: username)
                  case let .connectionsListView(userVm):
                    ConnectionsListView(userVm: userVm)
                  }
                }
            }
            .background(.black)
          }
          .environmentObject(router)
        }
    }
}
