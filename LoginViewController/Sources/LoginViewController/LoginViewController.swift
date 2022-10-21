import AutoLayoutBuilder
import LoginPresenter
import UIKit

public class LoginViewController: UIViewController {
    private let presenter: LoginPresenterType

    @EmailTextField()
    private var emailTextField: FormTextField
    @PasswordTextField()
    private var passwordTextField: FormTextField
    @SubmitButton()
    private var submitButton: UIButton
    @ActivityIndicator()
    private var activityIndicator: UIActivityIndicatorView
    @ActivityIndicatorContainer()
    private var activityIndicatorContainer: UIView
    @ActivityIndicatorBackground()
    private var activityIndicatorBackground: UIView

    public init(presenter: LoginPresenterType) {
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
        navigationItem.title = "Login"

        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)

        view.addSubviews(emailTextField, passwordTextField, submitButton) {
            $0.top(20).leading(40).trailing(-40) == view.safeAreaLayoutGuide

            $1.top(20) == $0.bottom
            $1.leading.trailing == $0

            $2.top(20) == $1.bottom
            $2.height == 44
            $2.leading(80).trailing(-80) == view.safeAreaLayoutGuide
        }

        view.addSubview(activityIndicatorBackground) {
            $0.edges == Superview()
            $0.addSubview(activityIndicatorContainer) {
                $0.center == Superview()
                $0.addSubview(activityIndicator) {
                    $0.edges(20) == Superview()
                }
            }
        }
        presenter.prepare()
    }

    @objc private func emailChanged() {
        presenter.setEmail(emailTextField.text ?? "")
    }

    @objc private func passwordChanged() {
        presenter.setPassword(passwordTextField.text ?? "")
    }

    @objc private func submitTapped() {
        Task {
            await presenter.submit()
        }
    }
}

extension LoginViewController: LoginPresenterDelegate {
    public func showLoading(_ shown: Bool) {
        if shown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        UIView.animate(withDuration: 0.3) {
            self.activityIndicatorBackground.alpha = self.activityIndicator.isAnimating ? 1 : 0
        }
    }

    public func configure(with state: LoginFormState) {
        emailTextField.isValid = state.emailIsValid
        passwordTextField.isValid = state.passwordIsValid
        submitButton.isEnabled = state.canSubmit
    }
}
