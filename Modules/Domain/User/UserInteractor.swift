import DependencyContainer

public protocol UserInteractorDelegate: AnyObject {}

public protocol UserInteracting: AnyObject {
    var delegate: UserInteractorDelegate? { get set }
    
    func fetchUser() async throws -> User
}

public class UserInteractor: UserInteracting {
    public weak var delegate: UserInteractorDelegate?

    @Dependency(\.userService) var userService

    public init() {}

    public func fetchUser() async throws -> User {
        try await userService.fetch()
    }
}
