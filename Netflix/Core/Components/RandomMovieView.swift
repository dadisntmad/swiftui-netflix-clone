import SwiftUI
import Kingfisher

struct RandomMovieView: View {
    var body: some View {
        NavigationStack {
            KFImage(URL(string: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/dnpatlJrEPiDSn5fzgzvxtiSnMo.jpg"))
                .resizable()
                .scaledToFit()
                .overlay {
                    Color.black.opacity(0.4)
                    
                    VStack {
                        Spacer()
                        
                        Text("Movie Name")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "play.fill")
                                    
                                    Text("Play")
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                HStack {
                                    Image(systemName: "plus")
                                    
                                    Text("Add to List")
                                        .fontWeight(.semibold)
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(Color(.darkGray))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            })
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    RandomMovieView()
}
