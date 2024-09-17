import SwiftUI

struct MovieDetailsView: View {
    let movie: MovieResultModel
    
    var body: some View {
        Text(movie.title)
    }
}

#Preview {
    MovieDetailsView(movie: MovieModel.MOCK_MOVIE.results[0])
}
