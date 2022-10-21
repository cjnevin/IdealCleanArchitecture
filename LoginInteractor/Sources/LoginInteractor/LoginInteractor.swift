import Foundation
import LoginEntity
import UserEntity

@MainActor
public protocol LoginInteractorDelegate: AnyObject {
    func didValidateForm(
        emailIsValid: Bool,
        passwordIsValid: Bool,
        canSubmit: Bool
    )
}

@MainActor
public protocol LoginInteractorType: AnyObject {
    var delegate: LoginInteractorDelegate? { get set }
    func prepare()
    func setEmail(_ email: Email)
    func setPassword(_ password: Password)
    func submit() async -> Bool
}

public typealias LoginDependencies = LoginApiDependency & UserStorageDependency

public class LoginInteractor: LoginInteractorType {
    public weak var delegate: LoginInteractorDelegate? {
        didSet {
            validateForm()
        }
    }
    private let deps: LoginDependencies
    private var request = LoginRequest() {
        didSet {
            validateForm()
        }
    }

    public init(deps: LoginDependencies) {
        self.deps = deps
    }

    public func prepare() {
        validateForm()
    }

    public func setEmail(_ email: Email) {
        request.email = email
    }

    public func setPassword(_ password: Password) {
        request.password = password
    }

    public func submit() async -> Bool {
        switch await deps.loginApi.login(request: request) {
        case .success(let user):
            await deps.userStorage.store(user: user)
            return true
        case .failure:
            return false
        }
    }

    private func validateForm() {
        delegate?.didValidateForm(
            emailIsValid: !request.email.isEmpty,
            passwordIsValid: !request.password.isEmpty,
            canSubmit: request.isValid
        )
    }
}
