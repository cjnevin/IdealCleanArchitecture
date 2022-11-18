import DependencyContainer

public protocol UserRepository: AnyObject {
    func clear() async
    func fetch() async throws -> User
    func store(_ user: User) async
}

public struct UserRepositoryDependencyKey: LazyDependencyKey {
    public static var value: (any UserRepository)?
}

extension DependencyContainer {
    public var UserRepository: any UserRepository {
        get { DependencyContainer[UserRepositoryDependencyKey.self] }
        set { DependencyContainer[UserRepositoryDependencyKey.self] = newValue }
    }
}
