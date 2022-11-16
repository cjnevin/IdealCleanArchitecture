import CommonCore   
import Foundation
import UserCore

@MainActor
public protocol LoginPresenterDelegate: AnyObject {
    func configure(with vm: LoginViewModel)
    func showLoading(_ shown: Bool)
    func clearPassword()
}

@MainActor
public protocol LoginPresenterType: AnyObject {
    var delegate: LoginPresenterDelegate? { get set }
    func prepare()
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func submit() async
    func logout() async
}

public class LoginPresenter: LoginPresenterType {
    public typealias Router = AlertRouterType & UserRouterType
    public weak var delegate: LoginPresenterDelegate?

    private let interactor: LoginInteractorType
    private let router: Router

    public init(
        interactor: LoginInteractorType,
        router: Router
    ) {
        self.interactor = interactor
        self.router = router
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
            router.showError(
                title: "Login failed",
                message: "Please check your credentials and try again."
            )
            return
        }
        router.start()
    }
}

extension LoginPresenter: LogoutDelegate {
    public func logout() async {
        delegate?.clearPassword()
        setPassword("")
        await interactor.logout()
        router.finish()
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

public struct LoginViewModel {
    public let emailIsValid: Bool
    public let passwordIsValid: Bool
    public let canSubmit: Bool
}
