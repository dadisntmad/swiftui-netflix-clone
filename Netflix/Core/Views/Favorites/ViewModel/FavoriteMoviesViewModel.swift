import Foundation
import Observation

@Observable class FavoriteMoviesViewModel {
    private let baseUrl = "https://api.themoviedb.org/3/account"
    
    var favoriteMovies: [MovieResultModel] = []
    
    init() {
        Task {
            try await fetchFavoriteMovies()
        }
    }
    
    private func fetchFavoriteMovies() async throws {
        guard let sessionId = StorageService.getValue(keyType: .sessionId) else { return }
        guard let accountId = StorageService.getValue(keyType: .accountId) else { return }
        
        guard let url = URL(string: "\(baseUrl)/\(accountId)/favorite/movies?&sort_by=created_at.desc&session_id=\(sessionId)&api_key=\(ApiKeys.apiKey)") else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
           
            favoriteMovies = movie.results
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
