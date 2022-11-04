import CommonCore
import Foundation
import DependencyContainer
import LoginCore
import UserCore

@MainActor
func registerDependencies() {
    DependencyContainer
        .set(LoginService(), for: LoginServiceDependencyKey.self)
        .set(UserService(), for: UserServiceDependencyKey.self)
        .set(AlertControllerFactory(), for: AlertControllerFactoryDependencyKey.self)
        .set(LoginViewControllerFactory(), for: LoginViewControllerFactoryDependencyKey.self)
        .set(UserViewControllerFactory(), for: UserViewControllerFactoryDependencyKey.self)
}
