import Foundation

@MainActor
public protocol LoginRoute: AnyObject {
    func startLogin()
}
