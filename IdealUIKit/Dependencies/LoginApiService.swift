import Foundation
import LoginService
import UserEntity

final class LoginApiService: LoginService {
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
