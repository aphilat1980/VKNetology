//
//  CurrentUserProfileView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    var currentUser: User
    
    @State private var showEditProfile = false
    
    @StateObject var viewModel: CurrentUserProfileViewModel
    
    init (user: User) {
        self.currentUser = user
        self._viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(user: user))
    }
    
    
    
   /*var currentUsersPosts: [Post] {
       return try await PostService.fetchUserPosts(user: currentUser)
       /*return postsDatabase.filter({$0.author.userName == currentUser.userName})*/
    }*/
    
    var body: some View {
        
        
        NavigationView {
            ScrollView {
                
                
                VStack {
                    
                    HStack {
                        //userID button
                        Text (currentUser.userName)
                        Spacer()
                        Button {
                            
                            AuthService.shared.sighOut()
                            
                        } label: {
                            Image("threeLineIcon")
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    
                    HStack {
                        
                        //foto name and profession
                        /*Image(currentUser.userFoto ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(30)*/
                        CircularProfileImageView(user: currentUser, dimension: 60)
                        VStack (alignment: .leading) {
                            Text (currentUser.userName)
                                .fontWeight(.bold)
                            Text (currentUser.userProfession ?? "")
                            
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    HStack {
                        Image("orangeCircle")
                        Text ("Подробная информация")
                        
                    }
                    /*NavigationLink {
                        EditProfileView()
                    } label: {
                        Text ("Редактировать")
                            .frame(width: 360, height: 35)
                            .foregroundColor(.white)
                            .background {
                                Color.orange
                            }
                            .cornerRadius(6)
                    }*/

                    
                    Button {
                        
                        showEditProfile.toggle()
                        
                    } label: {
                        Text ("Редактировать")
                            .frame(width: 360, height: 35)
                            .foregroundColor(.white)
                            .background {
                                Color.orange
                            }
                            .cornerRadius(6)
                        
                        
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
                            ForEach (0...15, id: \.self) { photo in
                                Image ("post1Foto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 72, height: 66, alignment: .top)
                                    .cornerRadius(10)
                                
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
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: currentUser)
        }
        
    }
        
        
    }



/*struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(currentUser: users[0])
    }
}*/
