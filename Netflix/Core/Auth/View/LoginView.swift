import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    private var isValid: Bool {
        return !username.isEmpty && !password.isEmpty
    }
    
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
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                        .textFieldViewModifier()
                    
                    
                    SecureField("Password", text: $password)
                        .textFieldViewModifier()
                    
                    CustomButton(
                        title: "Sign In",
                        isLoading: false,
                        isValid: isValid,
                        action: {}
                    )
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
