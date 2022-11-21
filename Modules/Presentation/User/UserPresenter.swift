import Domain
import Foundation

@MainActor
public protocol UserPresenting: AnyObject {
    var view: UserView? { get set }
    func prepare() async throws
    func logout() async
}

public class UserPresenter: UserPresenting {
    public typealias Routes = LogoutRoute & UserRoute
    
    weak public var delegate: UserDelegate?
    weak public var view: UserView?

    private let interactor: UserInteracting
    private let router: Routes

    public init(
        interactor: UserInteracting,
        router: Routes
    ) {
        self.interactor = interactor
        self.router = router
    }

    public func prepare() async throws {
        view?.showLoading(true)
        let user = try await interactor.fetchUser()
        view?.configure(with: .init(
            id: user.id.uuidString,
            age: "\(user.age.wrappedValue)",
            name: user.name.wrappedValue
        ))
        view?.showLoading(false)
    }

    public func logout() async {
        view?.showLoading(true)
        await delegate?.logout()
        router.logout()
        view?.showLoading(false)
    }
}
