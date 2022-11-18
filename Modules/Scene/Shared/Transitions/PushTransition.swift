import UIKit

public final class PushTransition: NSObject {
    public var isAnimated: Bool
    private weak var from: UIViewController?
    private var openCompletionHandler: (() -> Void)?
    private var closeCompletionHandler: (() -> Void)?

    private var navigationController: UINavigationController? {
        guard let navigation = from as? UINavigationController else { return from?.navigationController }
        return navigation
    }

    public init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension PushTransition: Transition {
    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        self.from = from
        openCompletionHandler = completion
        navigationController?.delegate = self
        navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        closeCompletionHandler = completion
        navigationController?.popViewController(animated: isAnimated)
    }
}

extension PushTransition: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let transitionCoordinator = navigationController.transitionCoordinator,
            let fromVC = transitionCoordinator.viewController(forKey: .from),
            let toVC = transitionCoordinator.viewController(forKey: .to) else { return }

        if fromVC == from {
            openCompletionHandler?()
            openCompletionHandler = nil
        } else if toVC == from {
            closeCompletionHandler?()
            closeCompletionHandler = nil
        }
    }
}
