import LoginInteractor
import LoginEntity
import UserCoordinator

@MainActor
public protocol LoginPresenterDelegate: AnyObject {
    func configure(with state: LoginFormState)
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
        guard await interactor.submit() else {
            return coordinator.showError("Login failed")
        }
        coordinator.start()
    }
}

extension LoginPresenter: LoginInteractorDelegate {
    public func didValidateForm(emailIsValid: Bool, passwordIsValid: Bool, canSubmit: Bool) {
        delegate?.configure(
            with: .init(
                emailIsValid: emailIsValid,
                passwordIsValid: passwordIsValid,
                canSubmit: canSubmit
            )
        )
    }
}
