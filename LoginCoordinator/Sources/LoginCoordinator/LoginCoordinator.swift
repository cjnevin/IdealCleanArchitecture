import LoginViewController
import LoginPresenter
import LoginInteractor
import UserCoordinator
import ViewControllerTypes

@MainActor
public protocol LoginCoordinatorType: AnyObject {
    func start()
}

public class LoginCoordinator: LoginCoordinatorType {
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
            coordinator: UserCoordinator(
                navigationController: navigationController,
                deps: deps
            )
        )
        let viewController = LoginViewController(presenter: presenter)
        navigationController.push(viewController, animated: false)
    }
}
