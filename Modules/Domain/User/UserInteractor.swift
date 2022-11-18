import DependencyContainer

public protocol UserInteracting: AnyObject {
    func fetchUser() async throws -> User
}

public class UserInteractor: UserInteracting {
    @Dependency(\.userService) var userService

    public init() {}

    public func fetchUser() async throws -> User {
        try await userService.fetch()
    }
}
