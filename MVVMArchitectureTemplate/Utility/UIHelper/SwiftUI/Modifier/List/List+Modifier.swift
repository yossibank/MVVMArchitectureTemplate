import SwiftUI

extension View {
    func listBackground(_ color: Color) -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden).background(color)
        } else {
            return self
        }
    }
}
