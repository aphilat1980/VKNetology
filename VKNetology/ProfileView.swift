//
//  ProfileView.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var profilePosts: [Post] {
        return postsDatabase.filter({$0.author.userName == user.userName})
    }
    
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
                        Image(user.userFoto ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(30)
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
                        Image("orangeCircle")
                        Text ("Подробная информация")
                        
                    }
                    
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
                        Text ("15")
                        Spacer()
                        NavigationLink {
                            FotoView()
                        } label: {
                            Image("nextLabel")
                        }


                        
                    }
                    .padding(.horizontal, 30)
                    .padding (.top, 15)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack {
                            ForEach (0...10, id:\.self) { photo in
                                Image ("post1Foto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 72, height: 66, alignment: .top)
                                    .cornerRadius(10)
                                
                            }
                            
                        }
                        .padding(.leading, 30)
                    }
                    
                    ForEach(profilePosts) {post in
                        
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
