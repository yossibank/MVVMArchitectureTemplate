import Combine
import SwiftUI
import UIKit

protocol ViewModel: ObservableObject {
    associatedtype Input: InputObject
    associatedtype Output: OutputObject
    associatedtype Binding: BindingObject
    associatedtype Routing: RoutingObject

    var input: Input { get }
    var output: Output { get }
    var binding: Binding { get }
    var routing: Routing { get }
}

extension ViewModel where
    Binding.ObjectWillChangePublisher == ObservableObjectPublisher,
    Output.ObjectWillChangePublisher == ObservableObjectPublisher {
    var objectWillChange: AnyPublisher<Void, Never> {
        Publishers.Merge(
            binding.objectWillChange,
            output.objectWillChange
        )
        .eraseToAnyPublisher()
    }
}

protocol InputObject: AnyObject {}

protocol OutputObject: ObservableObject {}

protocol BindingObject: ObservableObject {}

protocol RoutingObject {
    var viewController: UIViewController! { get set }
}

@propertyWrapper
struct BindableObject<T: BindingObject> {
    @dynamicMemberLookup
    struct Wrapper {
        fileprivate let binding: T

        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<T, Value>) -> Binding<Value> {
            .init(
                get: { self.binding[keyPath: keyPath] },
                set: { self.binding[keyPath: keyPath] = $0 }
            )
        }
    }

    var wrappedValue: T

    var projectedValue: Wrapper {
        .init(binding: wrappedValue)
    }
}
