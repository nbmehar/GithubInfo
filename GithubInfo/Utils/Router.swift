//
//  Router.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Hashable {
        case search
        case userDetails(String)
        case connectionsListView(UserViewModel)
    }

    @Published var navPath = NavigationPath()

    func replaceAll(with destination: Destination) {
        withAnimation {
            navigateToRoot()
            navigate(to: destination)
        }
    }

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
