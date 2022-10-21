import UserEntity

public protocol UserInteractorDelegate: AnyObject {
}

public protocol UserInteractorType: AnyObject {
    var delegate: UserInteractorDelegate? { get set }
    
    func fetchUser() async throws -> User
}

public class UserInteractor: UserInteractorType {
    public weak var delegate: UserInteractorDelegate?

    private let deps: UserStorageDependency
    public init(deps: UserStorageDependency) {
        self.deps = deps
    }

    public func fetchUser() async throws -> User {
        try await deps.userStorage.fetch()
    }
}
