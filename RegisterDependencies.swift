import Foundation
import DependencyContainer
import LoginCore
import UserCore

func registerDependencies() {
    DependencyContainer
        .set(LoginApi(), for: LoginServiceDependencyKey.self)
        .set(UserStorage(), for: UserServiceDependencyKey.self)
}
