import SwiftUI

struct MovieInfoButton: View {
    let iconName: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 16) {
                Image(systemName: iconName)
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .frame(height: 32)
                
                Text(label)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    MovieInfoButton(iconName: "plus", label: "My List", action: {})
}
