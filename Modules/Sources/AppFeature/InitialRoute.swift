import DependencyContainer
import LoginService
import LoginServiceLive
import SharedFeature
import UserService
import UserServiceLive
import UIKit

@MainActor
public func startApp(in window: UIWindow?) -> Router {
    DependencyContainer
        .set(DelayedLoginService(), for: LoginServiceDependencyKey.self)
        .set(DelayedUserService(), for: UserServiceDependencyKey.self)
    let tabRouter = TabRouter(window: window)
    tabRouter.startHome()
    tabRouter.startSettings()
    tabRouter.selectSettingsTab()
    return tabRouter
}
