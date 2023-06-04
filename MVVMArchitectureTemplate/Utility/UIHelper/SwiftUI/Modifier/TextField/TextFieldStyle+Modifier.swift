import SwiftUI

struct SampleTextFieldStyle: TextFieldStyle {
    var color: Color = .primary

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 1)
            )
    }
}
