import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        VStack {
            // app bar
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                })
                
                Spacer()
                
                Text("username")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                EmptyView()
            }
            .padding(.horizontal)
            
            // profiles
            HStack(spacing: 24) {
                VStack {
                    Image("profile_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                    
                    Text("username")
                        .font(.subheadline)
                        .bold()
                }
                
                VStack {
                    Image(systemName: "plus")
                        .foregroundStyle(.gray)
                        .frame(width: 75, height: 75)
                        .overlay {
                            Rectangle()
                                .stroke(.gray, lineWidth: 1)
                        }
                    
                    Text("Add Profile")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .bold()
                }
            }
            .padding(.bottom, 24)
            
            // manage profile button
            Button(action: {
                
            }, label: {
                HStack {
                    Image(systemName: "pencil")
                    
                    Text("Manage Profiles")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .bold()
                }
            })
            .padding(.bottom, 16)
            
            // menu
            VStack(spacing: 1) {
                MenuItemRow(imagePath: "checkmark", label: "My List")
                MenuItemRow(imagePath: "gearshape.fill", label: "App Settings")
                MenuItemRow(imagePath: "person.fill", label: "Account")
                MenuItemRow(imagePath: "questionmark.circle", label: "Help")
            }
            .padding(.bottom, 16)
            
            // sign out button
            Button(action: {
                Task {
                    try await authViewModel.signOut()
                }
            }, label: {
                if authViewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Sign Out")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .fontWeight(.medium)
                }
            })
            
            Spacer()
        }
        .tint(.white)
    }
}

#Preview {
    ProfileView()
        .environment(AuthViewModel())
}
