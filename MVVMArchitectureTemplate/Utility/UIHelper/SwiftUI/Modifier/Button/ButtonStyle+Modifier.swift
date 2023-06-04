import SwiftUI

struct SampleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.init(top: 16, leading: 40, bottom: 16, trailing: 40))
            .font(.subheadline)
            .foregroundColor(isEnabled ? .primary : .primary.opacity(0.3))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isEnabled ? Color.primary : Color.primary.opacity(0.3),
                        lineWidth: 1
                    )
            )
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.easeOut, value: 0.1)
    }
}
