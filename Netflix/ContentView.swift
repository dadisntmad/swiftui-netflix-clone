import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainView()
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
