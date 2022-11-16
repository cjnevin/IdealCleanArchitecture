import AutoLayoutBuilder
import Core
import UIKit

public final class SettingsViewController: ViewController<SettingsPresenting> {
    public override init(presenter: SettingsPresenting) {
        super.init(presenter: presenter)
        tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(login))
    }
    
    @objc private func login() {
        presenter.login()
    }
    
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        presenter.finish()
//    }
}

extension SettingsViewController: SettingsView {}
