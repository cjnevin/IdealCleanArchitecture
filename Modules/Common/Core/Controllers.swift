import Foundation

public protocol ViewControllerType: AnyObject {}

public enum NavigationType {
    case push(ViewControllerType)
    case present(ViewControllerType)
    case pop
    case dismiss
}

public protocol NavigationControllerType: AnyObject {
    func navigate(
        _ type: NavigationType,
        animated: Bool
    )
}

public enum AlertStyle {
    case alert
    case actionSheet
}

public enum AlertActionStyle {
    case cancel
    case destructive
    case `default`
}

public struct AlertAction {
    public let title: String
    public let style: AlertActionStyle
    public let callback: () -> Void

    public init(
        title: String,
        style: AlertActionStyle,
        callback: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.callback = callback
    }
}
