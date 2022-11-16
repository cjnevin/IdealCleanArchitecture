import Core
import UIKit

extension DefaultRouter: SettingsRoute {
    public func startSettings() {
        let transition = TabTransition(at: 1)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = SettingsPresenter(interactor: SettingsInteractor(), router: router)
        let viewController = SettingsViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        router.root = navigationController
        route(to: navigationController, as: transition)
    }
    
    private var tabBarController: UITabBarController? {
        guard let tabBarController = root as? UITabBarController else {
            return root?.tabBarController
        }
        return tabBarController
    }
    
    public func selectSettingsTab() {
        tabBarController?.selectedIndex = 1
    }
}
