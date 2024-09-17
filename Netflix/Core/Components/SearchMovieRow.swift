import SwiftUI
import Kingfisher

struct SearchMovieRow: View {
    let movie: MovieResultModel
    
    var body: some View {
        HStack {
            HStack {
                KFImage(URL(string: getPosterPath(path: movie.posterPath ?? "")))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .frame(maxWidth: 170)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(movie.title)
                    .font(.subheadline)
                    .bold()
            }
            
            Spacer()
            
            Image(systemName: "play.circle")
                .font(.system(size: 36))
  
        }
    }
}

#Preview {
    SearchMovieRow(movie: MovieModel.MOCK_MOVIE.results[0])
}
