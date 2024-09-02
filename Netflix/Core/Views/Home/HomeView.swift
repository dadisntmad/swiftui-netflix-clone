import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home View")
            }
            
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("For username")
                        .font(.title3)
                        .bold()
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 8) {
                        NavigationLink {
                            
                        } label: {
                            Image(systemName: "4k.tv.fill")
                        }
                        
                        
                        NavigationLink {
                            
                        } label: {
                            Image("search")
                                .renderingMode(.template)
                        }
                        
                        
                        NavigationLink {
                            ProfileView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image("profile_image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }
                        
                    }
                }
            })
        }
        .tint(.white)
    }
}

#Preview {
    HomeView()
}
