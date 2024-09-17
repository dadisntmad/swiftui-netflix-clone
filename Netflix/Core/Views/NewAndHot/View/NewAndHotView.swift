import SwiftUI

struct NewAndHotView: View {
    var username: String
    
    @State private var upcomingMovieViewModel = NewAndHotViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 4) {
                        Text("🍿")
                        Text("Coming Soon")
                    }
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVStack {
                        ForEach(upcomingMovieViewModel.sortedAndFilteredUpcomingMovies) { movie in
                            UpcomingMovieView(movie: movie)
                                .onAppear {
                                    if movie.id == upcomingMovieViewModel.sortedAndFilteredUpcomingMovies.last?.id {
                                        Task {
                                            try await upcomingMovieViewModel.fetchUpcomingMovies()
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("New & Hot")
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
                            SearchView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image("search")
                                .renderingMode(.template)
                        }
                        
                        
                        NavigationLink {
                            ProfileView(username: username)
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
    NewAndHotView(username: "username")
}
