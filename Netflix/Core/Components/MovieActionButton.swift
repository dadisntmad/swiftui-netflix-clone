import SwiftUI

struct MovieActionButton: View {
    let label: String
    let iconName: String
    let fillColor: Color
    let contentColor: Color
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: iconName)
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .frame(height: 42)
            .frame(maxWidth: .infinity)
            .foregroundStyle(contentColor)
            .background(fillColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    MovieActionButton(label: "Play", iconName: "play.fill", fillColor: .white, contentColor: .black)
}
