import CommonConfig
import UIKit

class FormTextField: UITextField {
    var isValid: Bool = false {
        didSet {
            layer.borderColor = isValid ? validColor.cgColor : invalidColor.cgColor
        }
    }

    var validColor: UIColor = .black
    var invalidColor: UIColor = .black
}

@propertyWrapper
struct EmailStyle {
    @Lazy var wrappedValue = configure(FormTextField()) { textField in
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1
        textField.validColor = .systemGreen
        textField.invalidColor = .systemRed
    }
}

@propertyWrapper
struct PasswordStyle {
    @Lazy var wrappedValue = configure(FormTextField()) { textField in
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.validColor = .systemGreen
        textField.invalidColor = .systemRed
    }
}

@propertyWrapper
struct SubmitStyle {
    @Lazy var wrappedValue = configure(UIButton()) { button in
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
    }
}
