//
//  ProfileView.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    let user: User
    
    //@StateObject var viewModel: ProfileViewViewModel
    @StateObject var viewModel: CurrentUserProfileViewModel
    
    init (user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(user: user))
    }
    
    /*var profilePosts: [Post] {
        return postsDatabase.filter({$0.author.userName == user.userName})
    }*/
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                
                VStack {
                    
                    HStack {
                        //userID button
                        Text (user.userName)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("threeLineIcon")
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    
                    HStack {
                        
                        //foto name and profession
                        CircularProfileImageView(user: user, dimension: 60)
                            
                        VStack (alignment: .leading) {
                            Text (user.userName)
                                .fontWeight(.bold)
                            Text (user.userProfession ?? "")
                            
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    
                    HStack {
                        
                        Button {
                            
                        } label: {
                            Text ("Сообщение")
                                .frame(width: 160, height: 35)
                                .foregroundColor(.white)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(6)
                            
                        }
                        
                        Button {
                            
                        } label: {
                            Text ("Позвонить")
                                .frame(width: 160, height: 35)
                                .foregroundColor(.white)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(6)
                            
                        }
                        
                    }
                    HStack {
                        
                        VStack {
                            Text ("1400")
                            Text("публикаций")
                                .font(.footnote)
                        }
                        
                        Spacer()
                        VStack {
                            Text ("477")
                            Text("подписок")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text ("161 тыс.")
                            Text("подписчиков")
                                .font(.footnote)
                        }
                        
                    }
                    .padding(.horizontal, 30)
                    Divider()
                    
                    
                    HStack {
                        
                        VStack {
                            Image("editLabel")
                            Text("Запись")
                                .font(.footnote)
                        }
                        
                        Spacer()
                        VStack {
                            Image("fotoLabel")
                            Text("История")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Image("pictureLabel")
                            Text("Фото")
                                .font(.footnote)
                        }
                        
                    }
                    .padding(.horizontal, 30)
                    
                    HStack{
                        Text ("Фотографии")
                        Text ("\(user.userImages?.count ?? 0)")
                        Spacer()
                        NavigationLink {
                            FotoView(user: user)
                        } label: {
                            Image("nextLabel")
                        }


                        
                    }
                    .padding(.horizontal, 30)
                    .padding (.top, 15)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack {
                            /*ForEach (0...10, id:\.self) { photo in
                                Image ("post1Foto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 72, height: 66, alignment: .top)
                                    .cornerRadius(10)
                                
                            }*/
                            if let images = user.userImages {
                                
                                ForEach (images, id: \.self) { imageUrl in
                                    
                                    KFImage(URL(string: imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 72, height: 66, alignment: .top)
                                        //.cornerRadius(10)
                                }
                                
                            }
                            
                        }
                        .padding(.leading, 30)
                    }
                    
                    ForEach(viewModel.posts) {post in
                        
                        PostView(post: post)
                    }
                    
                }
                
                
            }
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: users[0])
    }
}
