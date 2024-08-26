import SwiftUI
import Foundation

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension View {
    func textFieldViewModifier() -> some View {
        modifier(TextFieldViewModifier())
    }
}
