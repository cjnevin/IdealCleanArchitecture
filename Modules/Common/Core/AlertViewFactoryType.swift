import DependencyContainer
import Foundation

@MainActor
public protocol AlertViewFactoryType: AnyObject {
    func make(
        title: String,
        message: String,
        style: AlertStyle,
        actions: AlertAction...
    ) -> any ViewControllerType
}

public struct AlertViewFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any AlertViewFactoryType)?
}

extension DependencyContainer {
    public var alertViewFactory: any AlertViewFactoryType {
        get { DependencyContainer[AlertViewFactoryDependencyKey.self] }
        set { DependencyContainer[AlertViewFactoryDependencyKey.self] = newValue }
    }
}
