import UserEntity
import UserInteractor
import UserPresenter
import UserViewController
import ViewControllerTypes

@MainActor
public protocol UserCoordinatorType: AnyObject {
    func showError(_ error: String)
    func start()
}

public class UserCoordinator: UserCoordinatorType {
    private let deps: UserStorageDependency
    private let navigationController: NavigationController
    public init(
        navigationController: NavigationController,
        deps: UserStorageDependency
    ) {
        self.navigationController = navigationController
        self.deps = deps
    }

    public func showError(_ error: String) {
        print(error)
    }

    public func start() {
        let presenter = UserPresenter(
            interactor: UserInteractor(deps: deps)
        )
        navigationController.push(UserViewController(presenter: presenter), animated: true)
    }
}
