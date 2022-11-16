import Foundation
import DependencyContainer
import Core
import UI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var settingsRouter: DefaultRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyContainer
            .set(DelayedLoginService(), for: LoginServiceDependencyKey.self)
            .set(DelayedUserService(), for: UserServiceDependencyKey.self)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        let tabOneRouter = DefaultRouter(rootTransition: TabTransition(isAnimated: false))
        tabOneRouter.root = tabBarController
        tabOneRouter.startSettings()
        settingsRouter = tabOneRouter
        
//
//        let router = DefaultRouter(rootTransition: PushTransition(isAnimated: false))
//        router.root = navigationController
//        router.startLogin()
//        rootRouter = router

        self.window = window

        return true
    }
}

