import AutoLayoutBuilder
import SettingsPresentation
import UIKit

@MainActor
public final class SettingsViewController: ViewController<SettingsPresenting> {
    lazy var toggleButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(toggle))

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = toggleButton
        navigationItem.rightBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(login))
    }
    
    @objc private func toggle() {
        presenter.toggleHome()
    }
    
    @objc private func login() {
        presenter.login()
    }
}

extension SettingsViewController: SettingsView {
    public func configure(with vm: SettingsViewModel) {
        toggleButton.title = vm.homeButtonTitle
    }
}
