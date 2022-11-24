import Foundation

@MainActor
public protocol UserView: AnyObject {
    func configure(with vm: UserViewModel)
    func showLoading(_ shown: Bool)
}

public struct UserViewModel {
    public let id: String
    public let age: String
    public let name: String
}
