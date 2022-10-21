//
//  AppDelegate.swift
//  IdealUIKit
//
//  Created by Chris Nevin on 21/10/2022.
//

import LoginCoordinator
import LoginInteractor
import LoginEntity
import UserEntity
import UIKit

struct Dependencies: LoginDependencies {
    var loginApi: LoginApiType = LoginApi()
    var userStorage: UserStorageType = UserStorage()
}

class LoginApi: LoginApiType {
    func login(request: LoginRequest) async -> LoginResponse {
        var user = User()
        user.name = "John Smith"
        user.age = 25
        user.id.wrappedValue = UUID()
        user.isAdmin = false
        return .success(user)
    }
}

class UserStorage: UserStorageType {
    private var user: User?

    func fetch() async -> User? {
        user
    }

    func store(user: User) async {
        self.user = user
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let coordinator = LoginCoordinator(
            navigationController: navigationController,
            deps: Dependencies()
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        coordinator.start()

        self.window = window

        return true
    }
}

