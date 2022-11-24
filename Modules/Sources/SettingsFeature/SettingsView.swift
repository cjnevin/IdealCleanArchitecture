import Foundation

@MainActor
public protocol SettingsView: AnyObject {
    func configure(with vm: SettingsViewModel)
}

public struct SettingsViewModel {
    public let homeButtonTitle: String
}
