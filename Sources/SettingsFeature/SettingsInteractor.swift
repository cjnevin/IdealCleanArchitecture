import Foundation

public protocol SettingsInteractorDelegate: AnyObject {}

public protocol SettingsInteracting: AnyObject {
    var delegate: SettingsInteractorDelegate? { get set }
}

public class SettingsInteractor: SettingsInteracting {
    public weak var delegate: SettingsInteractorDelegate?
    public init() {}
}
