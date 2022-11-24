import HomeFeature
import SharedFeature
import UIKit

extension TabRouter: HomeRoute {
    public func startHome() {
        let transition = TabTransition(at: 0, name: "Home", icon: "house")
        let presenter = HomePresenter(interactor: HomeInteractor(), router: ())
        let viewController = HomeViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        homeRouter = DefaultRouter(rootTransition: transition)
        homeRouter?.root = navigationController
        route(to: navigationController, as: transition)
    }
    
    private var tabBarController: UITabBarController? {
        guard let tabBarController = root as? UITabBarController else {
            return root?.tabBarController
        }
        return tabBarController
    }
    
    public func selectHomeTab() {
        tabBarController?.selectedIndex = 0
    }
}

extension TabRouter: RemoveHomeRoute {
    public func removeHome() {
        homeRouter?.close()
    }
}
