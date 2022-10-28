import LoginViewController
import LoginPresenter
import LoginInteractor
import RouterTypes
import AlertRouter
import UserRouter
import ViewControllerTypes

public class LoginRouter: LoginRouterType {
    private let navigationController: NavigationController

    public init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let userRouter = UserRouter(navigationController: navigationController)
        let presenter = LoginPresenter(
            interactor: LoginInteractor(),
            alertRouter: AlertRouter(navigationController: navigationController),
            userRouter: userRouter
        )
        let viewController = LoginViewController(presenter: presenter)
        userRouter.logoutDelegate = viewController
        navigationController.navigate(.push(viewController), animated: false)
    }
}
