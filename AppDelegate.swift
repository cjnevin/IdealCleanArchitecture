import LoginCore
import CommonUI
import LoginUI
import UserUI
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
}

