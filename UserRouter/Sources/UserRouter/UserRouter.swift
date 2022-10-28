import UserEntity
import UserInteractor
import UserPresenter
import UserViewController
import LoginViewController
import RouterTypes
import ViewControllerTypes

public class UserRouter: UserRouterType {
    public weak var logoutDelegate: LogoutDelegate?
    private let navigationController: NavigationController

    public init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let presenter = UserPresenter(interactor: UserInteractor())
        let viewController = UserViewController(presenter: presenter)
        viewController.logoutDelegate = logoutDelegate
        navigationController.navigate(.push(viewController), animated: true)
    }

    public func finish() {
        navigationController.navigate(.pop, animated: true)
    }
}
