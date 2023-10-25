//
//  PostView.swift
//  VKNetology
//
//  Created by Александр Филатов on 04.10.2023.
//

import SwiftUI
import Kingfisher

struct PostView: View {
    
    var post: Post
    @State var isPresentedFullText: Bool = false
    
    @State var sheetIsPresented: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                if let user = post.author {
                    CircularProfileImageView(user: user, dimension: 60)
               }
                /*Image(post.author.userFoto ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(30)*/
                
                NavigationLink {
                    
                    ProfileView(user: post.author)
                    
                } label: {
                  
                    VStack (alignment: .leading) {
                        Text (post.author.userName)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text (post.author.userProfession ?? "")
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    
                }
                    /*VStack (alignment: .leading) {
                        Text (post.author.userName)
                            .fontWeight(.bold)
                        Text (post.author.userProfession)
                    }
                    .padding(.leading)*/
                
                Spacer()
                
                Button {
                    sheetIsPresented.toggle()
                } label: {
                    Image("threeDotsIcon")
                        .resizable()
                        .frame(width: 5, height: 21)
                        .padding(.trailing)
                }
                .sheet(isPresented: $sheetIsPresented) {
                    Text ("gghghgh")
                }
                

            }
            .padding(.top, 15)
            
            VStack {
                
                if let imageUrl = post.postFoto {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                    //.frame(width:UIScreen.main.bounds.width-40, height: 250)
                        .frame(height: 300, alignment: .top)
                        .clipped()
                    //.clipShape(RoundedRectangle(cornerRadius: 20))
                    //.padding()
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                    //.frame(width:UIScreen.main.bounds.width-40, height: 250)
                        .frame(height: 300, alignment: .top)
                        .clipped()
                }
                
                if isPresentedFullText {
                    Text (post.description)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .onTapGesture {
                            isPresentedFullText.toggle()
                            print(isPresentedFullText)
                        }
                    
                } else {
                    Text (post.description)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .lineLimit(3)
                    
                    Button {
                        isPresentedFullText.toggle()
                        print(isPresentedFullText)
                    } label: {
                        Text ("Показать полностью...")
                            //.padding()
                    }
                }
                
                
                Divider()
                    .foregroundColor(.black)
                
                HStack {
                    Image ("heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text ("\(post.postLikes)")
                    
                    Image ("message")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text ("\(post.postMessages)")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image ("bookmark")
                    }
                

                }
                .padding()
                //.padding(.bottom, 10)
                
            
                
                
                
                
            }
            .background {
                Color(.secondarySystemBackground)
            }
            
        }
        .padding(.horizontal)
        
    }
}

/*struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}*/
