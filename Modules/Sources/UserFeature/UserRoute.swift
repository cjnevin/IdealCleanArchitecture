import Foundation

@MainActor
public protocol UserRoute: AnyObject {
    func startUser(with delegate: UserDelegate)
}

@MainActor
public protocol UserDelegate: AnyObject {
    func logout() async
}
