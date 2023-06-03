import SwiftUI

extension View {
    @ViewBuilder
    func redacted(showPlaceholder: Bool) -> some View {
        if showPlaceholder {
            redacted(reason: .placeholder)
        } else {
            unredacted()
        }
    }
}

extension View {
    func foregroundColor(
        light lightColor: Color,
        dark darkColor: Color
    ) -> some View {
        modifier(
            AdaptiveForegroundColorModifier(
                lightColor: lightColor,
                darkColor: darkColor
            )
        )
    }

    func listBackground(_ color: Color) -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden).background(color)
        } else {
            return self
        }
    }
}
