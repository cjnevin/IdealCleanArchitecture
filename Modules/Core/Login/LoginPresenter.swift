import Foundation

@MainActor
public protocol LoginPresenting: AnyObject {
    var view: LoginView? { get set }
    func prepare()
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func submit() async
    func logout() async
}

public class LoginPresenter: LoginPresenting {
    public typealias Routes = AlertRoute & UserRoute
    public weak var view: LoginView?

    private let interactor: LoginInteracting
    private let router: Routes

    public init(
        interactor: LoginInteracting,
        router: Routes
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
            view?.showLoading(false)
        }
        view?.showLoading(true)
        guard await interactor.submit() else {
            router.showError(
                title: "Login failed",
                message: "Please check your credentials and try again."
            )
            return
        }
        router.startUser(with: self)
    }
}

extension LoginPresenter: UserParentPresenting {
    public func logout() async {
        view?.clearPassword()
        setPassword("")
        await interactor.logout()
    }
}

extension LoginPresenter: LoginInteractorDelegate {
    public func didValidateForm(_ state: LoginRequest.State) {
        view?.configure(
            with: .init(
                emailIsValid: state.emailIsValid,
                passwordIsValid: state.passwordIsValid,
                canSubmit: state.formIsValid
            )
        )
    }
}
