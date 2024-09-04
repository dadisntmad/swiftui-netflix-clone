struct MovieModel: Codable {
    let page: Int
    let results: [MovieResultModel]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieResultModel: Codable, Identifiable, Hashable {
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

extension MovieModel {
    static var MOCK_MOVIE: MovieModel = MovieModel(
        page: 1,
        results: [
            MovieResultModel(backdropPath: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/pjnD08FlMAIXsfOLKQbvmO0f0MD.jpg", genreIds: [10, 30], id: 718821, overview: "As storm season intensifies, the paths of former storm chaser Kate Carter and reckless social-media superstar Tyler Owens collide when terrifying phenomena never seen before are unleashed. The pair and their competing teams find themselves squarely in the paths of multiple storm systems converging over central Oklahoma in the fight of their lives.", posterPath: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/pjnD08FlMAIXsfOLKQbvmO0f0MD.jpg", releaseDate: "2024", title: "Twisters", voteAverage: 7.8),
            MovieResultModel(backdropPath: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/oGythE98MYleE6mZlGs5oBGkux1.jpg", genreIds: [10, 30], id: 718821, overview: "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.", posterPath: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/oGythE98MYleE6mZlGs5oBGkux1.jpg", releaseDate: "2024", title: "Bad Boys: Ride or Die", voteAverage: 7.8),
        ],
        totalPages: 10,
        totalResults: 30
    )
}
