import Foundation
import DependencyContainer
import Domain
import Infrastructure
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabRouter: TabRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyContainer
            .set(DelayedLoginService(), for: LoginServiceDependencyKey.self)
            .set(DelayedUserService(), for: UserServiceDependencyKey.self)

        window = UIWindow(frame: UIScreen.main.bounds)
        tabRouter = TabRouter(window: window)
        window?.makeKeyAndVisible()
        return true
    }
}
