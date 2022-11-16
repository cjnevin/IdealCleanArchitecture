import Core
import UIKit

extension DefaultRouter: HomeRoute {
    public func startHome() {
        let transition = TabTransition(at: 0)
        let presenter = HomePresenter(interactor: HomeInteractor(), router: ())
        let viewController = HomeViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
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
