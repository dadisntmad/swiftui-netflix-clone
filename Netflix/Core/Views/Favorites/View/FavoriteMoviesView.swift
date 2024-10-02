import SwiftUI
import Kingfisher

struct FavoriteMoviesView: View {
    @State private var viewModel = FavoriteMoviesViewModel()
    
    private var gridColumns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    var body: some View {
        if viewModel.favoriteMovies.isEmpty {
            Text("You don't have any favorite movies yet.")
                .font(.title2)
                .foregroundStyle(.gray)
                .bold()
                .multilineTextAlignment(.center)
        } else {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridColumns) {
                           ForEach(viewModel.favoriteMovies) { movie in
                               NavigationLink {
                                   MovieDetailsView(movieId: movie.id)
                                       .navigationBarBackButtonHidden()
                               } label: {
                                   VStack {
                                       KFImage(URL(string: getPosterPath(path: movie.posterPath ?? "")))
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 150, height: 225)
                                           .clipShape(RoundedRectangle(cornerRadius: 8))
                                           .clipped()
                                       
                                       Text(movie.title)
                                           .font(.subheadline)
                                           .fontWeight(.semibold)
                                           .multilineTextAlignment(.center)
                                           .padding(.top, 8)
                                   }
                               }
                           }
                       }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Text("Favorites")
                                .font(.title3)
                                .bold()
                            
                            Text("❤️")
                                .font(.subheadline)
                        }
                    }
                })
            }
        }
    
    }
}

#Preview {
    FavoriteMoviesView()
}
