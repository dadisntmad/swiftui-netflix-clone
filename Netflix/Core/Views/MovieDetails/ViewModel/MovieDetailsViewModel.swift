import Observation
import SwiftUI

@Observable class MovieDetailsViewModel {
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    var movie: MovieDetailsModel?
    var movies: [MovieResultModel] = []
    var isFavorite = false
    
    private var movieId: Int
    private var cast: [CastModel] = []
    private var crew: [CrewModel] = []
    
    private var similarMovieUrl: String {
        return "\(baseUrl)/\(movieId)/similar?api_key=\(ApiKeys.apiKey)"
    }
    
    private var creditsBaseUrl: String {
        return "\(baseUrl)/\(movieId)/credits?api_key=\(ApiKeys.apiKey)"
    }
    
    private var movieDetailsBaseUrl: String {
        return "\(baseUrl)/\(movieId)?append_to_response=videos&api_key=\(ApiKeys.apiKey)"
    }
    
    var castNames: String {
        return cast.map({ $0.name }).joined(separator: ", ")
    }
    
    var crewNames: String {
        return cast.map { $0.name }.joined(separator: ", ")
    }
    
    var videoKey: String? {
        return movie?.videos.results.first(where: ({ $0.type == "Trailer" && $0.site == "YouTube" }))?.key
    }
    
    var movieInfo: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        
        var releaseYear = ""
        
        if let releaseDate = movie?.releaseDate,
           let date = formatter.date(from: releaseDate) {
            let year = calendar.dateComponents([.year], from: date).year
            releaseYear = year.map { String($0) } ?? "Unknown"
        }
        
        let genres = movie?.genres.map({ $0.name }).joined(separator: " · ") ?? ""
        
        return "\(releaseYear) \(genres)"
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        
        Task {
            try await fetchMovieDetails()
            try await fetchSimilarMovies()
            try await fetchCredits()
            try await checkIfMovieIsFavorite()
        }
    }
    
    private func fetchMovieDetails() async throws {
        guard let url = URL(string: movieDetailsBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            let movie = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
            self.movie = movie
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
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
    
    func addToFavorites() async throws {
        guard let accountId = StorageService.getValue(keyType: .accountId) else { return }
        guard let sessionId = StorageService.getValue(keyType: .sessionId) else { return }
        
        let url = "https://api.themoviedb.org/3/account/\(accountId)/favorite?session_id=\(sessionId)&api_key=\(ApiKeys.apiKey)"
        
        guard let url = URL(string: url) else { throw NetworkEnum.badUrl }
        
        isFavorite.toggle()
        
        let body: [String: Any] = [
            "media_type": "movie",
            "media_id": movieId,
            "favorite": isFavorite
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (_, _) = try await URLSession.shared.data(for: request)
            
        } catch  {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
    
    private func checkIfMovieIsFavorite() async throws {
        guard let sessionId = StorageService.getValue(keyType: .sessionId) else { return }
        
        guard let url = URL(string: "\(baseUrl)/\(movieId)/account_states?session_id=\(sessionId)&api_key=\(ApiKeys.apiKey)") else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { throw NetworkEnum.failedToSerialize }
            guard let isFavorite = json["favorite"] as? Bool else { throw NetworkEnum.failedToSerialize }
            self.isFavorite = isFavorite
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
