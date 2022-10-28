import UserEntity
import Inject

public protocol UserInteractorDelegate: AnyObject {}

public protocol UserInteractorType: AnyObject {
    var delegate: UserInteractorDelegate? { get set }
    
    func fetchUser() async throws -> User
}

public class UserInteractor: UserInteractorType {
    public weak var delegate: UserInteractorDelegate?

    @Inject var userStorage: UserStorageType

    public init() {}

    public func fetchUser() async throws -> User {
        try await userStorage.fetch()
    }
}
