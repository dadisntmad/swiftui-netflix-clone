import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var searchViewModel = SearchViewModel()
    
    var body: some View {
        @Bindable var viewModel = searchViewModel
        
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                        searchViewModel.clearSearch()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    })
                    
                    TextField("Search", text: $viewModel.query)
                        .textInputAutocapitalization(.never)
                        .frame(height: 2)
                        .textFieldViewModifier()
                }
                .padding(.horizontal)
                
                if searchViewModel.query.trimmingCharacters(in: .whitespaces).isEmpty {
                    Spacer()
                    
                    Text("Start searching...")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.gray)
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(searchViewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                    SearchMovieRow(movie: movie)
                                        .tint(.white)
                                        .padding(.vertical, 5)
                                }
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
