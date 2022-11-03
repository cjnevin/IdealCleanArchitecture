import DependencyContainer
import UserEntity

public protocol UserService: AnyObject {
    func clear() async
    func fetch() async throws -> User
    func store(_ user: User) async
}

public class ThrowingUserService: UserService {
    struct Error: Swift.Error {}

    public func clear() async {}

    public func fetch() async throws -> UserEntity.User {
        throw Error()
    }

    public func store(_ user: UserEntity.User) async {}
}

public struct UserDependencyKey: DependencyKey {
    public static var currentValue: UserService = ThrowingUserService()
}

extension DependencyContainer {
    public var userService: UserService {
        get { DependencyContainer[UserDependencyKey.self] }
        set { DependencyContainer[UserDependencyKey.self] = newValue }
    }
}
