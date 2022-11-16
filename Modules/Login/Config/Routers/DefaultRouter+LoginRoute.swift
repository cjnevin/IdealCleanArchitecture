import CommonConfig
import LoginCore
import UserConfig

extension DefaultRouter: LoginRoute {
    public func startLogin() {
        let transition = PushTransition(isAnimated: false)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = LoginPresenter(interactor: LoginInteractor(), router: router)
        let viewController = LoginViewController(presenter: presenter)
        presenter.delegate = viewController
        router.root = viewController
        route(to: viewController, as: transition)
    }
}
