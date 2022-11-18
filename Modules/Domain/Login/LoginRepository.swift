import DependencyContainer
import Foundation
import PropertyWrappers

public typealias LoginResponse = User

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

public protocol LoginRepository: AnyObject {
    func login(_ request: LoginRequest) async throws -> LoginResponse
}

public struct LoginRepositoryDependencyKey: LazyDependencyKey {
    public static var value: (any LoginRepository)?
}

extension DependencyContainer {
    public var LoginRepository: any LoginRepository {
        get { DependencyContainer[LoginRepositoryDependencyKey.self] }
        set { DependencyContainer[LoginRepositoryDependencyKey.self] = newValue }
    }
}
