import Foundation

@MainActor
public protocol LogoutRoute: AnyObject {
    func logout()
}
