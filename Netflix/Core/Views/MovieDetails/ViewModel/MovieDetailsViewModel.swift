import Observation
import SwiftUI

@Observable class MovieDetailsViewModel {
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    private var movieId: Int
    var movies: [MovieResultModel] = []
    private var cast: [CastModel] = []
    private var crew: [CrewModel] = []
    
    private var similarMovieUrl: String {
        return "\(baseUrl)/\(movieId)/similar?api_key=\(ApiKeys.apiKey)"
    }
    
    private var creditsBaseUrl: String {
        return "\(baseUrl)/\(movieId)/credits?api_key=\(ApiKeys.apiKey)"
    }
    
    var castNames: String {
        return cast.map({ $0.name }).joined(separator: ", ")
    }
    
    var crewNames: String {
        return cast.map { $0.name }.joined(separator: ", ")
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        
        Task {
            try await fetchSimilarMovies()
            try await fetchCredits()
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
    
    private func fetchCredits() async throws {
        guard let url = URL(string: creditsBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            let team = try JSONDecoder().decode(MovieTeamModel.self, from: data)
            cast = team.cast
            crew = team.crew
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
