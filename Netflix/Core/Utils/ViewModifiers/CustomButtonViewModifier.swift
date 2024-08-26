import SwiftUI

struct CustomButtonViewModifier: ViewModifier {
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.white)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension View {
    func buttonViewModifier(background: Color) -> some View {
        modifier(CustomButtonViewModifier(background: background))
    }
}
