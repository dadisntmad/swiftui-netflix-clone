struct MovieTeamModel: Identifiable, Codable {
    let id: Int
    let cast: [CastModel]
    let crew: [CrewModel]
}

struct CastModel: Identifiable, Codable {
    let id: Int
    let knownForDepartment: String
    let name: String
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case character
    }
}

struct CrewModel: Identifiable, Codable {
    let id: Int
    let knownForDepartment: String
    let name: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case department
        case job
    }
}
