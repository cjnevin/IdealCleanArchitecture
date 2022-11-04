import CommonCore
import DependencyContainer
import Foundation
import UserCore

@MainActor
public protocol LoginViewControllerFactoryType: AnyObject {
    func make(
        presenter: any LoginPresenterType
    ) -> any LoginViewControllerType
}

public protocol LoginViewControllerType: ViewControllerType, LoginPresenterDelegate, LogoutDelegate {}

public struct LoginViewControllerFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any LoginViewControllerFactoryType)?
}

extension DependencyContainer {
    public var loginViewControllerFactory: any LoginViewControllerFactoryType {
        get { DependencyContainer[LoginViewControllerFactoryDependencyKey.self] }
        set { DependencyContainer[LoginViewControllerFactoryDependencyKey.self] = newValue }
    }
}
