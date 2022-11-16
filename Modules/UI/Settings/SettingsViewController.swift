import AutoLayoutBuilder
import Core
import UIKit

public final class SettingsViewController: ViewController<SettingsPresenting> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(login))
        tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
    }
    
    @objc private func login() {
        presenter.login()
    }
}

extension SettingsViewController: SettingsView {}
