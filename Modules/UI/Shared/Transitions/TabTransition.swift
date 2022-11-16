import UIKit

public final class TabTransition: NSObject {
    public var isAnimated: Bool
    private weak var from: UIViewController?

    private var tabBarController: UITabBarController? {
        guard let navigation = from as? UITabBarController else { return from?.tabBarController }
        return navigation
    }

    public init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension TabTransition: Transition {
    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        if let tabBarController {
            var controllers = tabBarController.viewControllers ?? []
            controllers.append(viewController)
            tabBarController.setViewControllers(controllers, animated: isAnimated)
            completion?()
        }
    }

    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        if let tabBarController {
            let controllers = tabBarController.viewControllers?.filter { $0 !== viewController } ?? []
            tabBarController.setViewControllers(controllers, animated: isAnimated)
            completion?()
        }
    }
}
