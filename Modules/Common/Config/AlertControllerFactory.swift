import CommonCore
import UIKit

@MainActor
public class AlertControllerFactory: AlertControllerFactoryType {
    public init() {}
    public func make(
        title: String,
        message: String,
        style: AlertStyle,
        actions: AlertAction...
    ) -> any ViewControllerType {
        UIAlertController.make(
            title: title,
            message: message,
            style: style,
            actions: actions
        )
    }
}

extension UIAlertController {
    static func make(
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
