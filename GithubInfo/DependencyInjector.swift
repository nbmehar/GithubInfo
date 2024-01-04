//
//  DependencyInjector.swift
//  GithubInfo
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation
import SwiftUI

class DependencyInjector {
    init() {}
    static let shared = DependencyInjector()

    // MARK: Services

    @ObservedObject var router = Router()
    lazy var userVm: UserViewModel = .init(userService: UserService(networkManager: NetworkManager.shared))

    // MARK: ViewModels

//    lazy var authVm: AuthViewModel = .init(
//        googleAuthService: GoogleAuthService(userGoogleSignInState: .signedOut(platform: .google)),
//        discordAuthService: DiscordAuthService(networkManager: NetworkManager.shared),
//        metaMaskService: MetaMaskService(userMetaSignInState: .signedOut(platform: .metamask)),
//        authService: authService)
//    
//    lazy var forgotPasswordViewModel : ForgotPasswordViewModel = .init(authService: authService)
//    lazy var changePasswordViewModel : ChangePasswordViewModel = .init(authService: authService)
//    lazy var homeTabViewModel : HomeTabViewModel = .init(homeService: HomeService(networkManager: NetworkManager.shared))
//    
//    lazy var gameListViewModel: GameListViewModel = .init(
//        gameService: GameService(networkManager: NetworkManager.shared))
//
//    lazy var profileVm: ProfileViewModel = .init(
//        profileService: ProfileService(networkManager: NetworkManager.shared))
}
