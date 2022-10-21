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
    var wrappedValue: FormTextField

    init(_ textField: FormTextField = .init()) {
        wrappedValue = textField
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
    var wrappedValue: FormTextField

    init(_ textField: FormTextField = .init()) {
        wrappedValue = textField
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
    var wrappedValue: UIButton

    init(_ button: UIButton = .init()) {
        wrappedValue = button
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
    }
}
