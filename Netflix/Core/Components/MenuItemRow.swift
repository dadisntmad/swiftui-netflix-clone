import SwiftUI

struct MenuItemRow: View {
    let imagePath: String
    let label: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack(spacing: 4) {
                Image(systemName: imagePath)
                Text(label)
                
                Spacer()
                
                Image("caret_right")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.white)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 8)
            .background(.gray.opacity(0.25))
            .foregroundStyle(.gray)
        })
        .tint(.white)
    }
}

#Preview {
    MenuItemRow(imagePath: "checkmark", label: "My List")
}
