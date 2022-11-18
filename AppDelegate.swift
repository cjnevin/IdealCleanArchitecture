import Foundation
import DependencyContainer
import Domain
import Infrastructure
import Scene
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabRouter: TabRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyContainer
            .set(DelayedLoginRepository(), for: LoginRepositoryDependencyKey.self)
            .set(DelayedUserRepository(), for: UserRepositoryDependencyKey.self)

        window = UIWindow(frame: UIScreen.main.bounds)
        tabRouter = TabRouter(window: window)
        window?.makeKeyAndVisible()
        tabRouter?.selectSettingsTab()
        return true
    }
}
