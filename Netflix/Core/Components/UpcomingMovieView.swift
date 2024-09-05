import SwiftUI
import Kingfisher

struct UpcomingMovieView: View {
    let movie: MovieResultModel
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: getPosterPath(path: movie.backdropPath ?? "")))
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            HStack(spacing: 4) {
                Text("Sep")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                
                Text("5")
                    .bold()
            }
            .padding(.bottom, 4)
            
            HStack {
                Text(movie.title)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bell")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    UpcomingMovieView(movie: MovieModel.MOCK_MOVIE.results[0])
}
