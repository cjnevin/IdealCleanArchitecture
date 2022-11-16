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
            router: CompositeRouter(
                alert: AlertRouter(navigationController: navigationController),
                user: userRouter
            )
        )
        let vc = loginViewControllerFactory.make(presenter: presenter)
        presenter.delegate = vc
        userRouter.logoutDelegate = presenter
        navigationController.navigate(.push(vc), animated: false)
    }
}

private class CompositeRouter: AlertRouterType, UserRouterType {
    let alert: AlertRouterType
    let user: UserRouterType
    
    init(alert: AlertRouterType, user: UserRouterType) {
        self.alert = alert
        self.user = user
    }
    
    func showError(title: String, message: String) {
        alert.showError(title: title, message: message)
    }
    
    func start() {
        user.start()
    }
    
    func finish() {
        user.finish()
    }
}
