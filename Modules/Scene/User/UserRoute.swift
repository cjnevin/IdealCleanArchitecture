import Domain
import Presentation

extension DefaultRouter: UserRoute {
    public func startUser(with parentPresenter: UserParentPresenting) {
        let transition = PushTransition(isAnimated: true)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = UserPresenter(interactor: UserInteractor(), router: router)
        let viewController = UserViewController(presenter: presenter)
        presenter.view = viewController
        presenter.parentPresenter = parentPresenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
}
