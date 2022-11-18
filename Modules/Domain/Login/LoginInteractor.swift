import DependencyContainer
import Foundation

@MainActor
public protocol LoginInteractorDelegate: AnyObject {
    func didValidateForm(_ state: LoginRequest.State)
}

@MainActor
public protocol LoginInteracting: AnyObject {
    var delegate: LoginInteractorDelegate? { get set }
    func prepare()
    func setEmail(_ email: Email)
    func setPassword(_ password: Password)
    func submit() async -> Bool
    func logout() async
}

public class LoginInteractor: LoginInteracting {
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

    @Dependency(\.LoginRepository) var LoginRepository
    @Dependency(\.UserRepository) var UserRepository

    public init() {}

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
            let user = try await LoginRepository.login(request)
            await UserRepository.store(user)
            return true
        } catch {
            return false
        }
    }

    public func logout() async {
        await UserRepository.clear()
    }

    private func validateForm() {
        state.emailIsValid = !request.email.isEmpty
        state.passwordIsValid = !request.password.isEmpty
        state.formIsValid = !isSubmitting && state.emailIsValid && state.passwordIsValid
        delegate?.didValidateForm(state)
    }
}
