import SwiftUI

struct AdaptiveForegroundColorModifier: ViewModifier {
    var lightColor: Color
    var darkColor: Color

    @Environment(\.colorScheme) private var colorScheme

    private var resolvedColor: Color {
        switch colorScheme {
        case .light:
            return lightColor

        case .dark:
            return darkColor

        @unknown default:
            return lightColor
        }
    }

    func body(content: Content) -> some View {
        content.foregroundColor(resolvedColor)
    }
}

struct AdaptiveBackgroundColorModifier: ViewModifier {
    var lightColor: Color
    var darkColor: Color

    @Environment(\.colorScheme) private var colorScheme

    private var resolvedColor: Color {
        switch colorScheme {
        case .light:
            return lightColor

        case .dark:
            return darkColor

        @unknown default:
            return lightColor
        }
    }

    func body(content: Content) -> some View {
        content.background(resolvedColor)
    }
}
