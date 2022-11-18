import UIKit

public protocol Deeplinkable: AnyObject {
    @discardableResult func route(to url: URL, as transition: Transition) -> Bool
}

public protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?)
}

@MainActor
public protocol Router: Routable {
    var root: UIViewController? { get set }
}
