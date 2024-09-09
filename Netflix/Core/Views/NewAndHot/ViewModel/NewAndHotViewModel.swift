import Foundation
import Observation

@Observable class NewAndHotViewModel {
    
    var upcomingMovies: [MovieResultModel] = []
    
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    private var upcomingMoviesBaseUrl: String {
        return "\(baseUrl)/upcoming?api_key=\(ApiKeys.apiKey)"
    }
    
    init() {
        Task {
            try await fetchUpcomingMovies()
        }
    }
    
    private func fetchUpcomingMovies() async throws {
        guard let url = URL(string: upcomingMoviesBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
            
            upcomingMovies = movie.results
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
