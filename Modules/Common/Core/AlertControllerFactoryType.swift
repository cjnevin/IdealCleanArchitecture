import DependencyContainer
import Foundation

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

@MainActor
public protocol AlertControllerFactoryType: AnyObject {
    func make(
        title: String,
        message: String,
        style: AlertStyle,
        actions: AlertAction...
    ) -> any ViewControllerType
}

public struct AlertControllerFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any AlertControllerFactoryType)?
}

extension DependencyContainer {
    public var alertControllerFactory: any AlertControllerFactoryType {
        get { DependencyContainer[AlertControllerFactoryDependencyKey.self] }
        set { DependencyContainer[AlertControllerFactoryDependencyKey.self] = newValue }
    }
}
