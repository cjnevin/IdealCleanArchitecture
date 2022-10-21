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
struct ActivityIndicatorBackground {
    var wrappedValue: UIView
    init(_ wrappedValue: UIView = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        wrappedValue.alpha = 0
    }
}

@propertyWrapper
struct ActivityIndicatorContainer {
    var wrappedValue: UIView
    init(_ wrappedValue: UIView = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.backgroundColor = .black
        wrappedValue.layer.cornerRadius = 22
    }
}

@propertyWrapper
struct ActivityIndicator {
    var wrappedValue: UIActivityIndicatorView

    init(_ wrappedValue: UIActivityIndicatorView = .init(style: UIActivityIndicatorView.Style.large)) {
        self.wrappedValue = wrappedValue
        wrappedValue.color = .white
        wrappedValue.hidesWhenStopped = true
    }
}

@propertyWrapper
struct EmailTextField {
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
struct PasswordTextField {
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
struct SubmitButton {
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
