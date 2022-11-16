import DependencyContainer
import Foundation
import PhantomTypes
import PropertyWrappers

public typealias LoginResponse = User

public extension Types {
    enum Email {}
    enum Password {}
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

public struct LoginServiceDependencyKey: LazyDependencyKey {
    public static var value: (any LoginService)?
}

extension DependencyContainer {
    public var loginService: any LoginService {
        get { DependencyContainer[LoginServiceDependencyKey.self] }
        set { DependencyContainer[LoginServiceDependencyKey.self] = newValue }
    }
}
