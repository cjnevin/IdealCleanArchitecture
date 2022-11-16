import Foundation

@MainActor
public protocol SettingsRoute: AnyObject {
    func startSettings()
}
