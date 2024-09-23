import Observation
import SwiftUI

@Observable class MovieDetailsViewModel {
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    private var movieId: Int
    var movies: [MovieResultModel] = []
    
    private var similarMovieUrl: String {
        return "\(baseUrl)/\(movieId)/similar?api_key=\(ApiKeys.apiKey)"
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        
        Task {
            try await fetchSimilarMovies()
        }
    }
    
    private func fetchSimilarMovies() async throws {
        guard let url = URL(string: similarMovieUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            let similarMovies = try JSONDecoder().decode(MovieModel.self, from: data)
            movies = similarMovies.results
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
