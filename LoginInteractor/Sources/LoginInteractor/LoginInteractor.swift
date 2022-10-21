import Foundation
import LoginEntity
import UserEntity

@MainActor
public protocol LoginInteractorDelegate: AnyObject {
    func didValidateForm(_ state: LoginRequest.State)
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
        didSet { validateForm() }
    }
    private var isSubmitting: Bool = false {
        didSet { validateForm() }
    }
    private var request = LoginRequest() {
        didSet { validateForm() }
    }
    private var state = LoginRequest.State()
    private let deps: LoginDependencies

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
        defer {
            isSubmitting = false
        }
        isSubmitting = true
        do {
            let user = try await deps.loginApi.login(request: request)
            await deps.userStorage.store(user: user)
            return true
        } catch {
            return false
        }
    }

    private func validateForm() {
        state.emailIsValid = !request.email.isEmpty
        state.passwordIsValid = !request.password.isEmpty
        state.formIsValid = !isSubmitting && state.emailIsValid && state.passwordIsValid
        delegate?.didValidateForm(state)
    }
}
