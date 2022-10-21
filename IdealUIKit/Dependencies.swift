import Foundation
import LoginEntity
import LoginInteractor
import UserEntity
import UserRouter
import ViewControllerTypes

struct Dependencies: LoginDependencies {
    var loginApi: LoginApiType = LoginApi()
    var userStorage: UserStorageType = UserStorage()
}

class LoginApi: LoginApiType {
    struct LoginError: Error {}

    func login(request: LoginRequest) async throws -> LoginResponse {
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

struct UserNotFoundError: Error {}

class UserStorage: UserStorageType {
    private var user: User?

    func fetch() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)

        guard let user = user else {
            throw UserNotFoundError()
        }
        return user
    }

    func store(user: User) async {
        self.user = user
    }

    func clear() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        self.user = nil
    }
}
