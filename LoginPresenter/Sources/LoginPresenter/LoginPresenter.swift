import LoginInteractor
import LoginEntity
import UserCoordinator

@MainActor
public protocol LoginPresenterDelegate: AnyObject {
    func configure(with state: LoginFormState)
    func showLoading(_ shown: Bool)
}

public struct LoginFormState {
    public let emailIsValid: Bool
    public let passwordIsValid: Bool
    public let canSubmit: Bool
}

@MainActor
public protocol LoginPresenterType: AnyObject {
    var delegate: LoginPresenterDelegate? { get set }
    func prepare()
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func submit() async
}

public class LoginPresenter: LoginPresenterType {
    public weak var delegate: LoginPresenterDelegate?

    private let interactor: LoginInteractorType
    private let coordinator: UserCoordinatorType

    public init(interactor: LoginInteractorType, coordinator: UserCoordinatorType) {
        self.interactor = interactor
        self.coordinator = coordinator
        interactor.delegate = self
    }

    public func prepare() {
        interactor.prepare()
    }

    public func setEmail(_ email: String) {
        interactor.setEmail(Email(email))
    }

    public func setPassword(_ password: String) {
        interactor.setPassword(Password(password))
    }

    public func submit() async {
        defer {
            delegate?.showLoading(false)
        }
        delegate?.showLoading(true)
        guard await interactor.submit() else {
            return coordinator.showError("Login failed")
        }
        coordinator.start()
    }
}

extension LoginPresenter: LoginInteractorDelegate {
    public func didValidateForm(_ state: LoginRequest.State) {
        delegate?.configure(
            with: .init(
                emailIsValid: state.emailIsValid,
                passwordIsValid: state.passwordIsValid,
                canSubmit: state.formIsValid
            )
        )
    }
}
