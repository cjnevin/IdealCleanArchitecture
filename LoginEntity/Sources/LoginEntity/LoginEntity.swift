import PhantomTypes
import PropertyWrappers
import UserEntity

public enum Types {
    public enum Email {}
    public enum Password {}
}

public typealias Email = Phantom<Types.Email, String>
public typealias Password = Phantom<Types.Password, String>

public protocol LoginApiType {
    func login(request: LoginRequest) async -> LoginResponse
}

public protocol LoginApiDependency {
    var loginApi: LoginApiType { get }
}

public typealias LoginResponse = Result<User, Error>

public struct LoginRequest {
    @RegEx("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    public var email: Email

    @Truncated(maxLength: 25)
    public var password: Password

    public var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    public init() {}
}
