import CommonCore
import DependencyContainer
import Foundation
import UserCore

@MainActor
public protocol LoginViewFactoryType: AnyObject {
    func make(
        presenter: any LoginPresenterType
    ) -> any LoginViewControllerType
}

public protocol LoginViewControllerType: ViewControllerType, LoginPresenterDelegate, LogoutDelegate {}

public struct LoginViewFactoryDependencyKey: LazyDependencyKey {
    public static var value: (any LoginViewFactoryType)?
}

extension DependencyContainer {
    public var loginViewFactory: any LoginViewFactoryType {
        get { DependencyContainer[LoginViewFactoryDependencyKey.self] }
        set { DependencyContainer[LoginViewFactoryDependencyKey.self] = newValue }
    }
}
