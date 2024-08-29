import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MainView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
