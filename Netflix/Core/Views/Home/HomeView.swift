import SwiftUI

struct HomeView: View {
    @State private var userViewModel = UserViewModel()
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if let randomMovie = homeViewModel.randomMovie {
                    RandomMovieView(movie: randomMovie)
                }
                
                VStack(alignment: .leading) {
                    MovieTypeTitleView(title: "Now Playing")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(homeViewModel.nowPlayingMovies) { movie in
                                MovieRowView(movie: movie)
                            }
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    MovieTypeTitleView(title: "Popular")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(homeViewModel.popularMovies) { movie in
                                MovieRowView(movie: movie)
                            }
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    MovieTypeTitleView(title: "Top Rated")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(homeViewModel.topRatedMovies) { movie in
                                MovieRowView(movie: movie)
                            }
                        }
                    }
                }
                .padding()
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
