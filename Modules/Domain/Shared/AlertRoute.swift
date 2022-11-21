import Foundation

@MainActor
public protocol AlertRoute: AnyObject {
    func showError(
        title: String,
        message: String
    )
}
