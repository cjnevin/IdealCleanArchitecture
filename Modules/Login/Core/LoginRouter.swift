import CommonCore
import DependencyContainer
import Foundation
import UserCore

@MainActor
public protocol LoginRouterType: AnyObject {
    func start()
}

public class LoginRouter: LoginRouterType {
    private let navigationController: any NavigationControllerType

    @Dependency(\.loginViewControllerFactory) var loginViewControllerFactory

    public init(navigationController: any NavigationControllerType) {
        self.navigationController = navigationController
    }

    public func start() {
        let userRouter = UserRouter(navigationController: navigationController)
        let presenter = LoginPresenter(
            interactor: LoginInteractor(),
            alertRouter: AlertRouter(navigationController: navigationController),
            userRouter: userRouter
        )
        let vc = loginViewControllerFactory.make(presenter: presenter)
        presenter.delegate = vc
        userRouter.logoutDelegate = presenter
        navigationController.navigate(.push(vc), animated: false)
    }
}
