import Foundation

@MainActor
public protocol SettingsPresenting: AnyObject {
    var view: SettingsView? { get set }
    func login()
    func toggleHome()
}

public protocol SettingsView: AnyObject {
    func configure(with vm: SettingsViewModel)
}

public struct SettingsViewModel {
    public let homeButtonTitle: String
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
