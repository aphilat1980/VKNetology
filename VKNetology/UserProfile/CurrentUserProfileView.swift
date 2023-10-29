//
//  CurrentUserProfileView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI
import Kingfisher

struct CurrentUserProfileView: View {
    
    var currentUser: User
    
    @State private var showEditProfile = false
    @StateObject var viewModel: ProfileViewModel
    
    init (user: User) {
        self.currentUser = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            AuthService.shared.sighOut()
                        } label: {
                    Text ("Выйти \nиз аккаунта")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.footnote)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    HStack {
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
                    
                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text ("Редактировать")
                            .frame(width: 360, height: 35)
                            .foregroundColor(.white)
                            .background {
                                Color.gray
                            }
                            .cornerRadius(6)
                    }
                    
                    
                    HStack {
                        VStack {
                            Text ("\(viewModel.posts.count)")
                            Text("публикаций")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text ("\(currentUser.subscription?.count ?? 0)")
                            Text("подписок")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text ("\(currentUser.subscribers?.count ?? 0)")
                            Text("подписчиков")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal, 30)
                    Divider()
                    HStack{
                        Text ("Фотографии")
                        Text ("\(currentUser.userImages?.count ?? 0)")
                        Spacer()
                        NavigationLink {
                            FotoView(user: currentUser)
                        } label: {
                            Image("nextLabel")
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding (.top, 15)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            if let images = currentUser.userImages {
                                ForEach (images, id: \.self) { imageUrl in
                                    KFImage(URL(string: imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 72, height: 66, alignment: .top)
                                        .padding(.horizontal)
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
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: currentUser)
        }
        .onAppear {
            Task {try await viewModel.fetchUserPosts()}
            Task {try await AuthService.shared.loadUserData()}
        }
    }
}



/*struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(currentUser: users[0])
    }
}*/
