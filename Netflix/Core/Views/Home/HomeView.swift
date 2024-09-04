import SwiftUI

struct HomeView: View {
    @State private var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                RandomMovieView(movie: MovieModel.MOCK_MOVIE.results[0])
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("For \(userViewModel.user?.username ?? "")")
                        .font(.title3)
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 8) {
                        NavigationLink {
                            
                        } label: {
                            Image(systemName: "4k.tv.fill")
                        }
                        
                        
                        NavigationLink {
                            
                        } label: {
                            Image("search")
                                .renderingMode(.template)
                        }
                        
                        
                        NavigationLink {
                            ProfileView(username: userViewModel.user?.username ?? "")
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image("profile_image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }
                    }
                }
            })
        }
        .tint(.white)
    }
}

#Preview {
    HomeView()
}
