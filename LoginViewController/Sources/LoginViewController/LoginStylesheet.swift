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

    init(_ wrappedValue: FormTextField = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.autocapitalizationType = .none
        wrappedValue.autocorrectionType = .no
        wrappedValue.placeholder = "Email"
        wrappedValue.keyboardType = .emailAddress
        wrappedValue.layer.borderWidth = 1
        wrappedValue.validColor = .systemGreen
        wrappedValue.invalidColor = .systemRed
    }
}

@propertyWrapper
struct PasswordStyle {
    var wrappedValue: FormTextField

    init(_ wrappedValue: FormTextField = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.autocapitalizationType = .none
        wrappedValue.autocorrectionType = .no
        wrappedValue.layer.borderWidth = 1
        wrappedValue.isSecureTextEntry = true
        wrappedValue.placeholder = "Password"
        wrappedValue.validColor = .systemGreen
        wrappedValue.invalidColor = .systemRed
    }
}

@propertyWrapper
struct SubmitStyle {
    var wrappedValue: UIButton

    init(_ wrappedValue: UIButton = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.layer.borderWidth = 1
        wrappedValue.layer.cornerRadius = 10
        wrappedValue.layer.borderColor = UIColor.black.cgColor
        wrappedValue.setTitle("Submit", for: .normal)
        wrappedValue.setTitleColor(.black, for: .normal)
        wrappedValue.setTitleColor(.gray, for: .disabled)
    }
}
