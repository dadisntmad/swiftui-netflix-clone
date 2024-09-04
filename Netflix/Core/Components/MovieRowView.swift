import SwiftUI
import Kingfisher

struct MovieRowView: View {
    let movie: MovieResultModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            KFImage(URL(string: movie.posterPath ?? ""))
                .resizable()
                .scaledToFit()
                .frame(height: 275)
            
            Text(movie.title)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MovieRowView(movie: MovieModel.MOCK_MOVIE.results[0])
}
