import SwiftUI

struct SearchView: View {
    @State private var query = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    })
                    
                    TextField("Search", text: $query)
                        .textInputAutocapitalization(.never)
                        .frame(height: 2)
                        .textFieldViewModifier()
                }
                .padding(.horizontal)
                
                if query.trimmingCharacters(in: .whitespaces).isEmpty {
                    Spacer()
                    
                    Text("Start searching...")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.gray)
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(MovieModel.MOCK_MOVIE.results) { movie in
                                SearchMovieRow(movie: movie)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView()
}
