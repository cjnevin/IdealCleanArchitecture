import Foundation
import UserService

public class DelayedUserService: UserService {
    private var user: User?

    public init() {}

    public func clear() async {
        try? await Task.sleep(nanoseconds: 250_000_000)
        user = nil
    }

    public func fetch() async throws -> User {
        struct UserNotFoundError: Error {}
        try await Task.sleep(nanoseconds: 250_000_000)
        guard let user = user else {
            throw UserNotFoundError()
        }
        return user
    }

    public func store(_ user: User) async {
        self.user = user
    }
}
