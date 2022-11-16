import AutoLayoutBuilder
import CommonConfig
import UserCore
import UIKit

public final class UserViewController: UIViewController {
    private let presenter: any UserPresenterType

    @NameStyle private var nameLabel
    @AgeStyle private var ageLabel
    @IDStyle private var idLabel
    @LoadingStyle private var loadingView

    init(presenter: any UserPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "User"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))

        view.addSubviews(nameLabel, ageLabel, idLabel) {
            $0.top(20).leading.trailing == view.safeAreaLayoutGuide

            $1.leading.trailing == $0
            $1.top(20) == $0.bottom

            $2.leading.trailing == $0
            $2.top(20) == $1.bottom
        }

        view.addSubview(loadingView) {
            $0.edges == Superview()
        }

        Task {
            try? await presenter.prepare()
        }
    }

    @objc private func logout() {
        Task {
            await presenter.logout()
        }
    }
}

extension UserViewController: UserPresenterDelegate {
    public func configure(with vm: UserViewModel) {
        nameLabel.text = vm.name
        ageLabel.text = vm.age
        idLabel.text = vm.id
    }

    public func showLoading(_ shown: Bool) {
        loadingView.show(shown)
    }
}
