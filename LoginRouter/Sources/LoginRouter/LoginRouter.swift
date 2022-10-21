import LoginViewController
import LoginPresenter
import LoginInteractor
import RouterTypes
import AlertRouter
import UserRouter
import ViewControllerTypes

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
        let userRouter = UserRouter(
            navigationController: navigationController,
            deps: deps
        )
        let presenter = LoginPresenter(
            interactor: LoginInteractor(deps: deps),
            alertRouter: AlertRouter(navigationController: navigationController),
            userRouter: userRouter
        )
        let viewController = LoginViewController(presenter: presenter)
        userRouter.logoutDelegate = viewController
        navigationController.navigate(.push(viewController), animated: false)
    }
}
