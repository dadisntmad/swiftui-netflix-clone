import Foundation
import Observation

@Observable class NewAndHotViewModel {
    private var upcomingMovies: [MovieResultModel] = []
    private var currentPage = 0
    
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    
    private var upcomingMoviesBaseUrl: String {
        return "\(baseUrl)/upcoming?page=\(currentPage)&api_key=\(ApiKeys.apiKey)"
    }
    
    var sortedAndFilteredUpcomingMovies: [MovieResultModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        return upcomingMovies
            .filter { movie in
                if let releaseDate = movie.releaseDate, let date = formatter.date(from: releaseDate) {
                    let movieComponents = calendar.dateComponents([.year, .month], from: date)
                    let currentComponents = calendar.dateComponents([.year, .month], from: currentDate)
                    
                    if let movieYear = movieComponents.year, let movieMonth = movieComponents.month,
                       let currentYear = currentComponents.year, let currentMonth = currentComponents.month {
                        
                        return movieYear > currentYear || (movieYear == currentYear && movieMonth >= currentMonth)
                    }
                }
                return false
            }
            .sorted {
                if let date1 = formatter.date(from: $0.releaseDate ?? ""),
                   let date2 = formatter.date(from: $1.releaseDate ?? "") {
                    return date1 < date2
                }
                return false
            }
    }
    
    init() {
        Task {
            try await fetchUpcomingMovies()
        }
    }
    
    func fetchUpcomingMovies() async throws {
        currentPage += 1
        guard let url = URL(string: upcomingMoviesBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            let movie = try JSONDecoder().decode(MovieModel.self, from: data)
            
            upcomingMovies.append(contentsOf: movie.results)
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
