import DependencyContainer
import PhantomTypes
import PropertyWrappers
import UserEntity

public typealias LoginResponse = User

public enum Types {
    public enum Email {}
    public enum Password {}
}

public typealias Email = Phantom<Types.Email, String>
public typealias Password = Phantom<Types.Password, String>

public struct LoginRequest {
    public struct State {
        public var emailIsValid: Bool = false
        public var passwordIsValid: Bool = false
        public var formIsValid: Bool = false

        public init() {}
    }

    @RegEx("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    public var email: Email

    @Truncated(maxLength: 25)
    public var password: Password

    public var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    public init() {}
}

public protocol LoginService: AnyObject {
    func login(_ request: LoginRequest) async throws -> LoginResponse
}

public class ThrowingLoginService: LoginService {
    struct Error: Swift.Error {}
    public func login(_ request: LoginRequest) async throws -> LoginResponse {
        throw Error()
    }
}

public struct LoginDependencyKey: DependencyKey {
    public static var currentValue: LoginService = ThrowingLoginService()
}

extension DependencyContainer {
    public var loginService: LoginService {
        get { DependencyContainer[LoginDependencyKey.self] }
        set { DependencyContainer[LoginDependencyKey.self] = newValue }
    }
}
