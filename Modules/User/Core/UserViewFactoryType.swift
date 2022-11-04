import CommonCore
import DependencyContainer
import Foundation

@MainActor
public protocol UserViewControllerType: ViewControllerType, UserPresenterDelegate {}

@MainActor
public protocol UserViewFactoryType: AnyObject {
    func make(
        presenter: any UserPresenterType,
        logoutDelegate: (any LogoutDelegate)?
    ) -> any UserViewControllerType
}

public struct UserViewFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any UserViewFactoryType)?
}

extension DependencyContainer {
    public var userViewFactory: any UserViewFactoryType {
        get { DependencyContainer[UserViewFactoryDependencyKey.self] }
        set { DependencyContainer[UserViewFactoryDependencyKey.self] = newValue }
    }
}
