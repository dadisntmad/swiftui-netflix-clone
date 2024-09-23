import SwiftUI
import Kingfisher

struct SimilarMovieItemRow: View {
    let movie: MovieResultModel
    
    var body: some View {
        HStack {
            HStack {
                KFImage(URL(string: getPosterPath(path: movie.backdropPath ?? "")))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(movie.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "arrow.down.square")
                .imageScale(.large)
        }
    }
}

#Preview {
    SimilarMovieItemRow(movie: MovieModel.MOCK_MOVIE.results[0])
}
