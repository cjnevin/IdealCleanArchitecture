import Domain
import UserPresentation
import UserScene

extension DefaultRouter: UserRoute {
    public func startUser(with delegate: UserDelegate) {
        let transition = PushTransition(isAnimated: true)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = UserPresenter(interactor: UserInteractor(), router: router)
        let viewController = UserViewController(presenter: presenter)
        presenter.view = viewController
        presenter.delegate = delegate
        router.root = viewController
        route(to: viewController, as: transition)
    }
}
