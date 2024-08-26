import SwiftUI

struct CustomButton: View {
    let title: String
    let isLoading: Bool
    let isValid: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            if isLoading {
                ProgressView()
                    .buttonViewModifier(
                        background: isLoading ? .gray.opacity(0.3) : Color("accentRed")
                    )
            } else {
                Text(title)
                    .buttonViewModifier(
                        background: isValid ? Color("accentRed") : .gray.opacity(0.3)
                    )
            }
        })
        .disabled(isLoading || !isValid)
    }
}

#Preview {
    CustomButton(title: "Sign In", isLoading: false, isValid: false, action: {})
}
