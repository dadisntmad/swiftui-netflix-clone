import SwiftUI

struct MovieTypeTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
    }
}

#Preview {
    MovieTypeTitleView(title: "Popular")
}
