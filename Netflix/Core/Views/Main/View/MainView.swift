import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Home")
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
            
            Text("New & Hot")
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
            
            Text("More")
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
}
