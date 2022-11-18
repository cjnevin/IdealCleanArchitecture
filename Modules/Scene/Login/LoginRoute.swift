import Domain
import Presentation
import UIKit

extension DefaultRouter: LoginRoute {
    public func startLogin() {
        let transition = ModalTransition.init(isAnimated: true, modalTransitionStyle: .coverVertical, modalPresentationStyle: .formSheet)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = LoginPresenter(interactor: LoginInteractor(), router: router)
        let viewController = LoginViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        router.root = navigationController
        route(to: navigationController, as: transition)
    }
}
