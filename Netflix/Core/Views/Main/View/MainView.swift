import SwiftUI

struct MainView: View {
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        TabView {
            HomeView(username: userViewModel.user?.username ?? "")
                .tabItem {
                    Label(
                        title: {
                            Text("Home")
                        },
                        icon: {
                            Image("home")
                                .renderingMode(.template)
                        }
                    )
                }
            
            NewAndHotView(username: userViewModel.user?.username ?? "")
                .tabItem {
                    Label(
                        title: {
                            Text("New & Hot")
                        },
                        icon: {
                            Image("new")
                                .renderingMode(.template)
                        }
                    )
                }
            
            FavoriteMoviesView()
                .tabItem {
                    Label(
                        title: {
                            Text("More")
                        },
                        icon: {
                            Image("more")
                                .renderingMode(.template)
                        }
                    )
                }
        }
        .tint(.white)
    }
}

#Preview {
    MainView()
        .environment(UserViewModel())
}
