import UIKit

@propertyWrapper
struct IDStyle {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .systemFont(ofSize: 10)
        wrappedValue.textColor = .purple
        wrappedValue.textAlignment = .center
    }
}

@propertyWrapper
struct NameStyle {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .boldSystemFont(ofSize: 15)
        wrappedValue.textColor = .black
        wrappedValue.textAlignment = .center
    }
}

@propertyWrapper
struct AgeStyle {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .boldSystemFont(ofSize: 15)
        wrappedValue.textColor = .blue
        wrappedValue.textAlignment = .center
    }
}
