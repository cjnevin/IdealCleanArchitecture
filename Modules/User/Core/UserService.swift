import DependencyContainer

public protocol UserServiceType: AnyObject {
    func clear() async
    func fetch() async throws -> User
    func store(_ user: User) async
}

public struct UserServiceDependencyKey: LazyDependencyKey {
    public static var value: (any UserServiceType)?
}

extension DependencyContainer {
    public var userService: any UserServiceType {
        get { DependencyContainer[UserServiceDependencyKey.self] }
        set { DependencyContainer[UserServiceDependencyKey.self] = newValue }
    }
}
