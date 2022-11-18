import DependencyContainer

public protocol UserInteractorDelegate: AnyObject {}

public protocol UserInteracting: AnyObject {
    var delegate: UserInteractorDelegate? { get set }
    
    func fetchUser() async throws -> User
}

public class UserInteractor: UserInteracting {
    public weak var delegate: UserInteractorDelegate?

    @Dependency(\.UserRepository) var UserRepository

    public init() {}

    public func fetchUser() async throws -> User {
        try await UserRepository.fetch()
    }
}
