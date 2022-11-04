import DependencyContainer

public protocol UserService: AnyObject {
    func clear() async
    func fetch() async throws -> User
    func store(_ user: User) async
}

public struct UserServiceDependencyKey: LazyDependencyKey {
    public static var value: UserService?
}

extension DependencyContainer {
    public var userService: UserService {
        get { DependencyContainer[UserServiceDependencyKey.self] }
        set { DependencyContainer[UserServiceDependencyKey.self] = newValue }
    }
}
