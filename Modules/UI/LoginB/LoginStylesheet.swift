import SharedUI
import UIKit

class FormTextField: UITextField {
    var isValid: Bool = false {
        didSet {
            backgroundColor = isValid ? validColor : invalidColor
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
        textField.placeholder = "Enter Email..."
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.validColor = .init(red: 0.4, green: 0.9, blue: 0.4, alpha: 0.3)
        textField.invalidColor = .init(red: 0.9, green: 0.4, blue: 0.4, alpha: 0.3)
    }
}

@propertyWrapper
struct PasswordStyle {
    @Lazy var wrappedValue = configure(FormTextField()) { textField in
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter Password..."
        textField.textColor = .white
        textField.validColor = .init(red: 0.4, green: 0.9, blue: 0.4, alpha: 0.3)
        textField.invalidColor = .init(red: 0.9, green: 0.4, blue: 0.4, alpha: 0.3)
    }
}

@propertyWrapper
struct SubmitStyle {
    @Lazy var wrappedValue = configure(UIButton()) { button in
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
    }
}
