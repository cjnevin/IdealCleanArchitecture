import Foundation
import DependencyContainer
import CommonConfig
import CommonCore
import LoginConfig
import LoginCore
import UserConfig
import UserCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerDependencies()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let coordinator = LoginRouter(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        coordinator.start()

        self.window = window

        return true
    }

    func registerDependencies() {
        DependencyContainer
            .set(LoginService(), for: LoginServiceDependencyKey.self)
            .set(UserService(), for: UserServiceDependencyKey.self)
            .set(AlertControllerFactory(), for: AlertControllerFactoryDependencyKey.self)
            .set(LoginViewControllerFactory(), for: LoginViewControllerFactoryDependencyKey.self)
            .set(UserViewControllerFactory(), for: UserViewControllerFactoryDependencyKey.self)
    }
}

