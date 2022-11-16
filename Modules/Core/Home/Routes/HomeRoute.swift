import Foundation

@MainActor
public protocol HomeRoute: AnyObject {
    func startHome()
}

@MainActor
public protocol RemoveHomeRoute: AnyObject {
    func removeHome()
}
