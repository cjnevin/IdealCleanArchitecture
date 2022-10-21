import UIKit

@propertyWrapper
struct IDLabel {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .systemFont(ofSize: 10)
        wrappedValue.textColor = .purple
        wrappedValue.textAlignment = .center
    }
}

@propertyWrapper
struct NameLabel {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .boldSystemFont(ofSize: 15)
        wrappedValue.textColor = .black
        wrappedValue.textAlignment = .center
    }
}

@propertyWrapper
struct AgeLabel {
    var wrappedValue: UILabel

    init(_ wrappedValue: UILabel = .init()) {
        self.wrappedValue = wrappedValue
        wrappedValue.font = .boldSystemFont(ofSize: 15)
        wrappedValue.textColor = .blue
        wrappedValue.textAlignment = .center
    }
}
