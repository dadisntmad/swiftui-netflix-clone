import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    let movie: MovieResultModel
    
    @State private var viewModel: MovieDetailsViewModel
    
    init(movie: MovieResultModel) {
        self.movie = movie
        self.viewModel = MovieDetailsViewModel(movieId: movie.id)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // video player
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: "https://c4.wallpaperflare.com/wallpaper/82/204/3/keanu-reeves-john-wick-movies-john-wick-chapter-2-wallpaper-preview.jpg"))
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                
                Button {
                    dismiss()
                } label: {
                    Circle()
                        .fill(.black.opacity(0.85))
                        .frame(width: 32, height: 32)
                        .padding()
                        .overlay {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                        }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                // title & genres
                Text("John Wick: Chapter 4")
                    .font(.title3)
                    .bold()
                
                Text("2023 Action, Triller, Crime")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                // action buttons
                MovieActionButton(
                    label: "Play",
                    iconName: "play.fill",
                    fillColor: .white,
                    contentColor: .black
                )
                
                MovieActionButton(
                    label: "Download",
                    iconName: "arrow.down.circle",
                    fillColor: .white.opacity(0.2),
                    contentColor: .white
                )
                
                // overview
                Text("Certified Fresh audience score. John Wick (Keanu Reeves) uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                // cast & director
                ExpandableTextView(text: "Cast: Keanu Reeves, Keanu Reeves, Keanu Reeves, Keanu Reeves, Keanu Reeves")
                ExpandableTextView(text: "Director: Keanu Reeves, Keanu Reeves, Keanu Reeves, Keanu Reeves, Keanu Reeves")
                
                HStack(spacing: 32) {
                    MovieInfoButton(
                        iconName: "plus",
                        label: "My List",
                        action: {}
                    )
                    
                    MovieInfoButton(
                        iconName: "hand.thumbsup",
                        label: "Rate",
                        action: {}
                    )
                    
                    MovieInfoButton(
                        iconName: "square.and.arrow.up",
                        label: "Share",
                        action: {}
                    )
                }
                .padding(.vertical, 8)
                
                Text("More Like This")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .bold()
                
                ForEach(viewModel.movies) { movie in
                    SimilarMovieItemRow(movie: movie)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    MovieDetailsView(movie: MovieModel.MOCK_MOVIE.results[0])
}

