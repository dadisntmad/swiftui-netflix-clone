import SwiftUI
import Observation

@Observable class HomeViewModel {
    var randomMovie: MovieResultModel?
    var nowPlayingMovies: [MovieResultModel] = []
    var popularMovies: [MovieResultModel] = []
    var topRatedMovies: [MovieResultModel] = []
    
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    private var nowPlayingBaseUrl: String {
        return "\(baseUrl)/now_playing?api_key=\(ApiKeys.apiKey)"
    }
    
    private var popularBaseUrl: String {
        return "\(baseUrl)/popular?api_key=\(ApiKeys.apiKey)"
    }
    
    private var topRatedBaseUrl: String {
        return "\(baseUrl)/top_rated?api_key=\(ApiKeys.apiKey)"
    }
    
    init() {
        Task {
            try await fetchData()
        }
    }
    
    private func makeRequest(baseUrl: String) async throws -> MovieModel {
        guard let url = URL(string: baseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
            
            return movie
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
    
    private func fetchData() async throws {
        let nowPlayingMovies = try await makeRequest(baseUrl: nowPlayingBaseUrl)
        let popularMovies = try await makeRequest(baseUrl: popularBaseUrl)
        let topRatedMovies = try await makeRequest(baseUrl: topRatedBaseUrl)
        
        
        self.randomMovie = popularMovies.results.randomElement()
        self.nowPlayingMovies = nowPlayingMovies.results
        self.popularMovies = popularMovies.results
        self.topRatedMovies = topRatedMovies.results
    }
}


