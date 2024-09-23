import SwiftUI

struct ExpandableTextView: View {
    @State private var isExpanded = false
    @State private var isTruncated = false
    
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.leading)
                .lineLimit(isExpanded ? nil : 1)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        let totalHeight = geometry.size.height
                        let lineHeight = UIFont.systemFont(ofSize: UIFont.systemFontSize).lineHeight
                        let maxHeight = lineHeight * 1
                        isTruncated = totalHeight > maxHeight
                    }
                })
            
            if isTruncated {
                Button(isExpanded ? "less" : "more") {
                    isExpanded.toggle()
                }
                .bold()
                .foregroundColor(.white.opacity(0.5))
            }
        }
    }
}


#Preview {
    ExpandableTextView(text: "When it comes to chicken there just isn’t anything more delicious than a juicy, crusty piece of finger-licking good fried chicken. It might seem intimidating to fry your own chicken, but it’s actually pretty straightforward and it puts grocery store and fast food fried chicken to shame.  If you have a thermometer for the oil and a timer, you can produce fail-proof fried chicken.  If you’ve ever wanted to make your own fried chicken, now is the time to try! When it comes to chicken there just isn’t anything more delicious than a juicy, crusty piece of finger-licking good fried chicken. It might seem intimidating to fry your own chicken, but it’s actually pretty straightforward and it puts grocery store and fast food fried chicken to shame.  If you have a thermometer for the oil and a timer, you can produce fail-proof fried chicken.  If you’ve ever wanted to make your own fried chicken, now is the time to try! ")
}
