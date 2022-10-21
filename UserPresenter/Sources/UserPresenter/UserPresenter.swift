import UserInteractor

@MainActor
public protocol UserPresenterType: AnyObject {
    var delegate: UserPresenterDelegate? { get set }
    func prepare()
}

public struct UserState {
    public var id: String
    public var age: String
    public var name: String
}

public protocol UserPresenterDelegate: AnyObject {
    func configure(with state: UserState)
}

public class UserPresenter: UserPresenterType {
    weak public var delegate: UserPresenterDelegate?

    private let interactor: UserInteractorType

    public init(interactor: UserInteractorType) {
        self.interactor = interactor
    }

    public func prepare() {
        Task {
            if let user = await interactor.fetchUser() {
                let state = UserState(
                    id: user.id.uuidString,
                    age: "\(user.age.wrappedValue)",
                    name: user.name.wrappedValue
                )
                delegate?.configure(with: state)
            }
        }
    }
}
