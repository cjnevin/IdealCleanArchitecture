import Foundation
import DependencyContainer
import LoginService
import UserService

func registerDependencies() {
    DependencyContainer
        .set(LoginApiService(), for: LoginServiceDependencyKey.self)
        .set(UserStorage(), for: UserServiceDependencyKey.self)
}
