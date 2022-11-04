public protocol ViewController: AnyObject {}

public enum NavigationType {
    case push(ViewController)
    case present(ViewController)
    case pop
    case dismiss
}

public protocol NavigationController: AnyObject {
    func navigate(_ type: NavigationType, animated: Bool)
}

#if canImport(UIKit)
import UIKit
extension UIViewController: ViewController {}
extension UINavigationController: NavigationController {
    public func navigate(_ type: NavigationType, animated: Bool) {
        switch type {
        case .present(let viewController as UIViewController):
            self.present(viewController, animated: animated, completion: nil)
        case .push(let viewController as UIViewController):
            self.pushViewController(viewController, animated: animated)
        case .pop:
            self.popViewController(animated: animated)
        case .dismiss:
            self.dismiss(animated: animated, completion: nil)
        default:
            break
        }
    }
}
#endif
