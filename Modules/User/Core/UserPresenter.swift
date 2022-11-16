import Foundation

@MainActor
public protocol UserPresenterType: AnyObject {
    var delegate: UserPresenterDelegate? { get set }
    func prepare() async throws
    func logout() async
}

public struct UserViewModel {
    public let id: String
    public let age: String
    public let name: String
}

public protocol UserPresenterDelegate: AnyObject {
    func configure(with vm: UserViewModel)
    func showLoading(_ shown: Bool)
}

public protocol UserParentPresenter: AnyObject {
    func logout() async
}

public class UserPresenter: UserPresenterType {
    public typealias Routes = UserRoute
    
    weak public var parentPresenter: UserParentPresenter?
    weak public var delegate: UserPresenterDelegate?

    private let interactor: UserInteractorType
    private let router: Routes

    public init(
        interactor: UserInteractorType,
        router: Routes
    ) {
        self.interactor = interactor
        self.router = router
    }

    public func prepare() async throws {
        delegate?.showLoading(true)
        let user = try await interactor.fetchUser()
        delegate?.configure(with: .init(
            id: user.id.uuidString,
            age: "\(user.age.wrappedValue)",
            name: user.name.wrappedValue
        ))
        delegate?.showLoading(false)
    }

    public func logout() async {
        delegate?.showLoading(true)
        await parentPresenter?.logout()
        delegate?.showLoading(false)
    }
}
