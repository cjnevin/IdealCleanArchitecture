import UserEntity

public protocol UserInteractorDelegate: AnyObject {
}

public protocol UserInteractorType: AnyObject {
    var delegate: UserInteractorDelegate? { get set }
    
    @available(macOS 10.15.0, *)
    func fetchUser() async -> User?
}

public class UserInteractor: UserInteractorType {
    public weak var delegate: UserInteractorDelegate?

    private let deps: UserStorageDependency
    public init(deps: UserStorageDependency) {
        self.deps = deps
    }

    @available(macOS 10.15.0, *)
    public func fetchUser() async -> User? {
        await deps.userStorage.fetch()
    }
}
