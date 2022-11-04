import CommonCore
import UIKit

extension UIAlertController {
    public static func make(
        title: String,
        message: String,
        style: AlertStyle,
        actions: [AlertAction]
    ) -> Self {
        let controller = Self.init(
            title: title,
            message: message,
            preferredStyle: style.style
        )
        actions.forEach {
            controller.addAction(.from($0))
        }
        return controller
    }
}

extension AlertStyle {
    var style: UIAlertController.Style {
        switch self {
        case .alert: return .alert
        case .actionSheet: return .actionSheet
        }
    }
}

extension UIAlertAction {
    static func from(_ action: AlertAction) -> Self {
        .init(
            title: action.title,
            style: action.style.style,
            handler: { _ in action.callback() }
        )
    }
}

extension AlertActionStyle {
    var style: UIAlertAction.Style {
        switch self {
        case .cancel: return .cancel
        case .destructive: return .destructive
        case .default: return .default
        }
    }
}

extension UIViewController: ViewControllerType {}

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
