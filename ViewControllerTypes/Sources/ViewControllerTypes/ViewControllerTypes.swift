public protocol ViewController: AnyObject {}

public protocol NavigationController: AnyObject {
    func push(_ viewController: ViewController, animated: Bool)
}

#if canImport(UIKit)
import UIKit
extension UIViewController: ViewController {}
extension UINavigationController: NavigationController {
    public func push(_ viewController: ViewController, animated: Bool) {
        if let uiViewController = viewController as? UIViewController {
            self.pushViewController(uiViewController, animated: animated)
        }
    }
}
#endif
