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
    private let deps: UserStorageDependency

    public init(
        navigationController: NavigationController,
        deps: UserStorageDependency
    ) {
        self.navigationController = navigationController
        self.deps = deps
    }

    public func start() {
        let presenter = UserPresenter(
            interactor: UserInteractor(deps: deps)
        )
        let viewController = UserViewController(presenter: presenter)
        viewController.logoutDelegate = logoutDelegate
        navigationController.navigate(.push(viewController), animated: true)
    }

    public func finish() {
        navigationController.navigate(.pop, animated: true)
    }
}
