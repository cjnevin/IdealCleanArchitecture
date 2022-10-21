import UserInteractor
import RouterTypes

@MainActor
public protocol UserPresenterType: AnyObject {
    var delegate: UserPresenterDelegate? { get set }
    func prepare()
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

public class UserPresenter: UserPresenterType {
    weak public var delegate: UserPresenterDelegate?

    private let interactor: UserInteractorType

    public init(interactor: UserInteractorType) {
        self.interactor = interactor
    }

    public func prepare() {
        Task {
            delegate?.showLoading(true)
            do {
                let user = try await interactor.fetchUser()
                delegate?.configure(with: .init(
                    id: user.id.uuidString,
                    age: "\(user.age.wrappedValue)",
                    name: user.name.wrappedValue
                ))
            } catch {

            }
            delegate?.showLoading(false)
        }
    }
}
