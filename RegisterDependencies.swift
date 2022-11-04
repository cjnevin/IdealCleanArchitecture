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
        .set(AlertViewFactory(), for: AlertViewFactoryDependencyKey.self)
        .set(LoginViewFactory(), for: LoginViewFactoryDependencyKey.self)
        .set(UserViewFactory(), for: UserViewFactoryDependencyKey.self)
}
