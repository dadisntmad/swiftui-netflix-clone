import Observation
import SwiftUI

@Observable class SearchViewModel {
    private var baseUrl = "https://api.themoviedb.org/3/search/movie"
    
    var query = "" {
        didSet {
            if query != oldValue {
                page = 0
            }
            Task {
                await debounceSearch()
            }
        }
    }
    
    
    var movies: [MovieResultModel] = []
    var page = 0
    
    private var debounce: Task<Void, Never>?
    
    private var searchBaseUrl: String {
        return "\(baseUrl)?query=\(query)&page=\(page)&api_key=\(ApiKeys.apiKey)"
    }
    
    func debounceSearch() async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        debounce?.cancel()
        debounce = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            if !Task.isCancelled {
                try? await searchMovie()
            }
        }
    }
    
    
    private func searchMovie() async throws {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            movies = []
            return
        }
        
        if page == 0 {
            movies = []
        }
        
        page += 1
        guard let url = URL(string: searchBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
            
            movies.append(contentsOf: movie.results)
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
    
    func clearSearch() {
        if !query.trimmingCharacters(in: .whitespaces).isEmpty  {
            query = ""
            movies = []
            page = 0
        }
    }
}
