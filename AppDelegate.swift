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
    var rootRouter: DefaultRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerDependencies()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let router = DefaultRouter(rootTransition: PushTransition(isAnimated: false))
        router.root = navigationController
        router.startLogin()
        rootRouter = router

        self.window = window

        return true
    }

    func registerDependencies() {
        DependencyContainer
            .set(LoginService(), for: LoginServiceDependencyKey.self)
            .set(UserService(), for: UserServiceDependencyKey.self)
    }
}

