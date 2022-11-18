import Domain
import Foundation

public protocol SettingsPresenting: AnyObject {
    var view: SettingsView? { get set }
    func login()
    func toggleHome()
}

public class SettingsPresenter: SettingsPresenting {
    public typealias Routes = LoginRoute & HomeRoute & RemoveHomeRoute

    weak public var view: SettingsView? {
        didSet {
            updateViewModel()
        }
    }

    private var showHome: Bool = true
    private let interactor: SettingsInteracting
    private let router: Routes

    public init(
        interactor: SettingsInteracting,
        router: Routes
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    public func login() {
        router.startLogin()
    }
    
    public func toggleHome() {
        if showHome {
            router.removeHome()
        } else {
            router.startHome()
        }
        showHome.toggle()
        updateViewModel()
    }
    
    private func updateViewModel() {
        view?.configure(with: .init(homeButtonTitle: showHome ? "Remove Home" : "Add Home"))
    }
}
