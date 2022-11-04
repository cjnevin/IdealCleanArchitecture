import Foundation
import LoginCore
import UserCore

final class LoginApi: LoginService {
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        struct LoginError: Error {}
        try await Task.sleep(nanoseconds: 500_000_000)

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
