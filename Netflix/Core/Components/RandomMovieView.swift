import SwiftUI
import Kingfisher

struct RandomMovieView: View {
    let movie: MovieResultModel
    
    var body: some View {
        NavigationStack {
            KFImage(URL(string: getPosterPath(path: movie.posterPath ?? "")))
                .resizable()
                .scaledToFit()
                .overlay {
                    Color.black.opacity(0.4)
                    
                    VStack {
                        Spacer()
                        
                        Text(movie.title)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink {
                                MovieDetailsView(movieId: movie.id)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Image(systemName: "play.fill")
                                    
                                    Text("Play")
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                HStack {
                                    Image(systemName: "plus")
                                    
                                    Text("Add to List")
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(Color(.darkGray))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            })
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    RandomMovieView(movie: MovieModel.MOCK_MOVIE.results[0])
}
