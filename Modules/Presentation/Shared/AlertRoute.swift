import Foundation

public protocol AlertRoute: AnyObject {
    func showError(
        title: String,
        message: String
    )
}
