import UIKit

@propertyWrapper
struct IDStyle {
    var wrappedValue: UILabel

    init(_ label: UILabel = .init()) {
        wrappedValue = label
        label.font = .systemFont(ofSize: 10)
        label.textColor = .purple
        label.textAlignment = .center
    }
}

@propertyWrapper
struct NameStyle {
    var wrappedValue: UILabel

    init(_ label: UILabel = .init()) {
        wrappedValue = label
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
    }
}

@propertyWrapper
struct AgeStyle {
    var wrappedValue: UILabel

    init(_ label: UILabel = .init()) {
        wrappedValue = label
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .blue
        label.textAlignment = .center
    }
}
