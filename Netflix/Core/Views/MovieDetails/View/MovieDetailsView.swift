import SwiftUI
import YouTubePlayerKit

struct MovieDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    let movieId: Int
    
    @State private var viewModel: MovieDetailsViewModel
    @State private var isFavorite = false
    
    init(movieId: Int) {
        self.movieId = movieId
        self.viewModel = MovieDetailsViewModel(movieId: movieId)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // video player
            ZStack(alignment: .topTrailing) {
                YouTubePlayerView(
                    YouTubePlayer(
                        source: .video(id: viewModel.videoKey ?? ""),
                        configuration: .init(
                            autoPlay: false,
                            showFullscreenButton: true
                        )
                    )
                )
                .frame(height: 250)
                
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
                Text(viewModel.movie?.title ?? "")
                    .font(.title3)
                    .bold()
                
                Text(viewModel.movieInfo)
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
                Text(viewModel.movie?.overview ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                // cast & director
                ExpandableTextView(text: "Cast: \(viewModel.castNames)")
                ExpandableTextView(text: "Director: \(viewModel.crewNames)")
                
                HStack(spacing: 32) {
                    MovieInfoButton(
                        iconName: isFavorite ? "checkmark" : "plus",
                        label: "My List",
                        action: {
                            Task {
                                isFavorite.toggle()
                                try await viewModel.addToFavorites(isFavorite: isFavorite)
                            }
                        }
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
    MovieDetailsView(movieId: 1231233)
}

