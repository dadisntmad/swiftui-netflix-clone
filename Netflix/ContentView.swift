import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()
    @State private var userViewModel = UserViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainView()
                    .environment(userViewModel)
            } else {
                LoginView()
            }
        }
        .environment(authViewModel)
    }
}

#Preview {
    ContentView()
}
