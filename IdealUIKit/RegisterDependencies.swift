import Foundation
import DependencyContainer
import LoginService
import UserService

func registerDependencies() {
    DependencyContainer[LoginServiceDependencyKey.self] = LoginApiService()
    DependencyContainer[UserServiceDependencyKey.self] = UserStorage()
}
