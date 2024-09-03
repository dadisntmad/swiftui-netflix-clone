import SwiftUI
import AlertToast

struct LoginView: View {
    @State private var showToast = false
    
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        @Bindable var viewModel = authViewModel
        
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
                    TextField("Username", text: $viewModel.username)
                        .textInputAutocapitalization(.never)
                        .textFieldViewModifier()
                    
                    SecureField("Password", text: $viewModel.password)
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
        .environment(AuthViewModel())
}
