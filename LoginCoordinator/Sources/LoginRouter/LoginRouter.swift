import LoginViewController
import LoginPresenter
import LoginInteractor
import UserRouter
import ViewControllerTypes

@MainActor
public protocol LoginRouterType: AnyObject {
    func start()
}

public class LoginRouter: LoginRouterType {
    private let navigationController: NavigationController
    private let deps: LoginDependencies

    public init(
        navigationController: NavigationController,
        deps: LoginDependencies
    ) {
        self.navigationController = navigationController
        self.deps = deps
    }

    public func start() {
        let presenter = LoginPresenter(
            interactor: LoginInteractor(deps: deps),
            coordinator: UserRouter(
                navigationController: navigationController,
                deps: deps
            )
        )
        let viewController = LoginViewController(presenter: presenter)
        navigationController.push(viewController, animated: false)
    }
}
