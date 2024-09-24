struct MovieDetailsModel: Identifiable, Codable {
    let id: Int
    let backdropPath: String?
    let genres: [Genre]
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

struct Genre: Identifiable, Codable {
    let id: Int
    let name: String
}
