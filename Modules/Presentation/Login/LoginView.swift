import Foundation

@MainActor
public protocol LoginView: AnyObject {
    func configure(with vm: LoginViewModel)
    func showLoading(_ shown: Bool)
    func clearPassword()
}

public struct LoginViewModel {
    public let emailIsValid: Bool
    public let passwordIsValid: Bool
    public let canSubmit: Bool
}
