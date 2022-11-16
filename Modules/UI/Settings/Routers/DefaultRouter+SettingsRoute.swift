import Core
import UIKit

extension DefaultRouter: SettingsRoute {
    public func startSettings() {
        let transition = TabTransition(isAnimated: false)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = SettingsPresenter(interactor: SettingsInteractor(), router: router)
        let viewController = SettingsViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        router.root = navigationController
        route(to: navigationController, as: transition)
    }
}
