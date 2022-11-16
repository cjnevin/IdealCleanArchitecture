import Foundation

@MainActor
public protocol SettingsPresenting: AnyObject {
    var view: SettingsView? { get set }
    func login()
    func close()
}

public protocol SettingsView: AnyObject {}

public class SettingsPresenter: SettingsPresenting {
    public typealias Routes = Closable & LoginRoute

    weak public var view: SettingsView?

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
    
    public func close() {
        router.close()
    }
}
