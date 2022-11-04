import CommonCore
import DependencyContainer
import Foundation

@MainActor
public protocol LogoutDelegate: AnyObject {
    func logout() async
}

@MainActor
public protocol UserRouterType: AnyObject {
    func start()
    func finish()
}

public class UserRouter: UserRouterType {
    public weak var logoutDelegate: (any LogoutDelegate)?
    private let navigationController: any NavigationControllerType

    @Dependency(\.userViewControllerFactory) var userViewControllerFactory

    public init(navigationController: any NavigationControllerType) {
        self.navigationController = navigationController
    }

    public func start() {
        let presenter = UserPresenter(interactor: UserInteractor())
        let vc = userViewControllerFactory.make(presenter: presenter, logoutDelegate: logoutDelegate)
        presenter.delegate = vc
        navigationController.navigate(.push(vc), animated: true)
    }

    public func finish() {
        navigationController.navigate(.pop, animated: true)
    }
}
