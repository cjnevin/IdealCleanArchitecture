import Foundation
import DependencyContainer
import Core
import UI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabRouter: TabRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyContainer
            .set(DelayedLoginService(), for: LoginServiceDependencyKey.self)
            .set(DelayedUserService(), for: UserServiceDependencyKey.self)
        
        let tabBarController = UITabBarController()
        tabRouter = TabRouter(rootTransition: EmptyTransition())
        tabRouter?.root = tabBarController
        
        tabRouter?.startHome()
        tabRouter?.startSettings()
        tabRouter?.selectSettingsTab()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
