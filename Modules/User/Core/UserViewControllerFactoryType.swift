import CommonCore
import DependencyContainer
import Foundation

@MainActor
public protocol UserViewControllerType: ViewControllerType, UserPresenterDelegate {}

@MainActor
public protocol UserViewControllerFactoryType: AnyObject {
    func make(
        presenter: any UserPresenterType,
        logoutDelegate: (any LogoutDelegate)?
    ) -> any UserViewControllerType
}

public struct UserViewControllerFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any UserViewControllerFactoryType)?
}

extension DependencyContainer {
    public var userViewControllerFactory: any UserViewControllerFactoryType {
        get { DependencyContainer[UserViewControllerFactoryDependencyKey.self] }
        set { DependencyContainer[UserViewControllerFactoryDependencyKey.self] = newValue }
    }
}
