import CommonCore
import UIKit

extension UINavigationController: NavigationControllerType {
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
