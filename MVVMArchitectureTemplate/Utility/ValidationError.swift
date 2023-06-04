enum ValidationError {
    case none
    case empty
    case long

    var isEnabled: Bool {
        self == .none
    }

    var description: String {
        switch self {
        case .none:
            return ""

        case .empty:
            return "文字が入力されていません。"

        case .long:
            return "入力された文字が長すぎます。20文字以内でご入力ください。"
        }
    }

    static func addValidate(_ input: String) -> ValidationError {
        if input.isEmpty {
            return .empty
        }

        if input.count > 20 {
            return .long
        }

        return .none
    }

    static func editValidate(_ input: String) -> ValidationError {
        input.isEmpty ? .empty : .none
    }
}
