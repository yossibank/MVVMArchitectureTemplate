enum FAParameter: String {
    case screenId
    case userId

    var rawValue: String {
        switch self {
        case .screenId: L10n.Fa.Parameter.screenId
        case .userId: L10n.Fa.Parameter.userId
        }
    }
}
