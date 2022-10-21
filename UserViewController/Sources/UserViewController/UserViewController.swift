import AutoLayoutBuilder
import UIKit
import UserPresenter

public class UserViewController: UIViewController {
    private let presenter: UserPresenterType

    @NameLabel()
    private var nameLabel: UILabel
    @AgeLabel()
    private var ageLabel: UILabel
    @IDLabel()
    private var idLabel: UILabel

    public init(presenter: UserPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "User"

        view.addSubviews(nameLabel, ageLabel, idLabel) {
            $0.top(20).leading.trailing == view.safeAreaLayoutGuide

            $1.leading.trailing == $0
            $1.top(20) == $0.bottom

            $2.leading.trailing == $0
            $2.top(20) == $1.bottom
        }

        presenter.prepare()
    }
}

extension UserViewController: UserPresenterDelegate {
    public func configure(with state: UserState) {
        nameLabel.text = state.name
        ageLabel.text = state.age
        idLabel.text = state.id
    }
}
