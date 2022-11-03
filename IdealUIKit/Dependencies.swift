import Foundation
import LoginService
import UserEntity
import UserService
import ViewControllerTypes
import DependencyContainer

func registerDependencies() {
    DependencyContainer[LoginServiceDependencyKey.self] = LoginApi()
    DependencyContainer[UserDependencyKey.self] = UserStorage()
}

class LoginApi: LoginService {
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        struct LoginError: Error {}
        try await Task.sleep(nanoseconds: 1_000_000_000)

        if request.password == "fail" {
            throw LoginError()
        }

        var user = User()
        user.name = "John Smith"
        user.age = 25
        user.id.wrappedValue = UUID()
        user.isAdmin = false

        return user
    }
}

class UserStorage: UserService {
    private var user: User?

    func clear() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        user = nil
    }

    func fetch() async throws -> User {
        struct UserNotFoundError: Error {}
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard let user = user else {
            throw UserNotFoundError()
        }
        return user
    }

    func store(_ user: UserEntity.User) async {
        self.user = user
    }
}
