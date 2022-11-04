import Foundation
import UserCore

class UserStorage: UserService {
    private var user: User?

    func clear() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        user = nil
    }

    func fetch() async throws -> User {
        struct UserNotFoundError: Error {}
        try await Task.sleep(nanoseconds: 500_000_000)
        guard let user = user else {
            throw UserNotFoundError()
        }
        return user
    }

    func store(_ user: User) async {
        self.user = user
    }
}
