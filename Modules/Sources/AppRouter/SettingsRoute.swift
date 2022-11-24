import SettingsFeature
import UIKit

extension TabRouter: SettingsRoute {
    public func startSettings() {
        let transition = TabTransition(at: 1, name: "Settings", icon: "gear")
        let presenter = SettingsPresenter(interactor: SettingsInteractor(), router: self)
        let viewController = SettingsViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        settingsRouter = DefaultRouter(rootTransition: transition)
        settingsRouter?.root = navigationController
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
