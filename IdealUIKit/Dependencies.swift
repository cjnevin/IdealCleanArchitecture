import Foundation
import LoginEntity
import LoginInteractor
import UserEntity

struct Dependencies: LoginDependencies {
    var loginApi: LoginApiType = LoginApi()
    var userStorage: UserStorageType = UserStorage()
}

class LoginApi: LoginApiType {
    func login(request: LoginRequest) async -> LoginResponse {
        var user = User()
        user.name = "John Smith"
        user.age = 25
        user.id.wrappedValue = UUID()
        user.isAdmin = false
        return .success(user)
    }
}

class UserStorage: UserStorageType {
    private var user: User?

    func fetch() async -> User? {
        user
    }

    func store(user: User) async {
        self.user = user
    }
}
