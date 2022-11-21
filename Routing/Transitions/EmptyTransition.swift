import UIKit

public final class EmptyTransition {
    public var isAnimated: Bool = true
    public init() {}
}

extension EmptyTransition: Transition {
    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
