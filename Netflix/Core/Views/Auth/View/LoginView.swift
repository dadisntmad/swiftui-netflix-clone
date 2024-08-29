import SwiftUI
import AlertToast

struct LoginView: View {
    @State private var authViewModel = AuthViewModel()
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
                .ignoresSafeArea(edges: .top)
            VStack {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .background(.black)
                
                Spacer()
                
                VStack(spacing: 24) {
                    TextField("Username", text: $authViewModel.username)
                        .textInputAutocapitalization(.never)
                        .textFieldViewModifier()
                    
                    SecureField("Password", text: $authViewModel.password)
                        .textFieldViewModifier()
                    
                    CustomButton(
                        title: "Sign In",
                        isLoading: authViewModel.isLoading,
                        isValid: authViewModel.isValid,
                        action: {
                            Task {
                                do {
                                    try await authViewModel.login()
                                } catch {
                                    showToast.toggle()
                                }
                            }
                        }
                    )
                }
                .padding()
                
                Spacer()
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(
                displayMode: .hud,
                type: .error(Color("accentRed")),
                title: "Something went wrong", subTitle: "Please try again later"
            )
        }
    }
}

#Preview {
    LoginView()
}
