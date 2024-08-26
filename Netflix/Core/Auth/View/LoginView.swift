import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
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
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Sign In")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color("accentRed"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
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
