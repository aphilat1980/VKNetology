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
    @State var photoSheetIsPresented = false
    @State var deltaSubscription: Int = 0
    @StateObject var viewModel: ProfileViewModel
    
    init (user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text (user.userName)
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    HStack {
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
                    
                    
                    if viewModel.isSubscribed {
                        Button {
                            Task {try await viewModel.removeSubcription()}
                            viewModel.isSubscribed.toggle()
                            deltaSubscription -= 1
                        } label: {
                            Text ("Отписаться")
                                .frame(width: 250, height: 35)
                                .foregroundColor(.white)
                                .background {
                                    Color.gray
                                }
                                .cornerRadius(6)
                        }
                    } else {
                        Button {
                            Task {try await viewModel.addSubcription()}
                            viewModel.isSubscribed.toggle()
                            deltaSubscription += 1
                        } label: {
                            Text ("Подписаться")
                                .frame(width: 250, height: 35)
                                .foregroundColor(.white)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(6)
                        }
                    }
                    
                    HStack {
                        VStack {
                            Text ("\(viewModel.posts.count)")
                            Text("публикаций")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text ("\(user.subscription?.count ?? 0)")
                            Text("подписок")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text ("\((user.subscribers?.count ?? 0) + deltaSubscription)")
                            Text("подписчиков")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal, 30)
                    Divider()
                    HStack{
                        Text ("Фотографии")
                        Text ("\(user.userImages?.count ?? 0)")
                        Spacer()
                        Button {
                            photoSheetIsPresented.toggle()
                        } label: {
                            Image("nextLabel")
                        }
                        .sheet(isPresented: $photoSheetIsPresented) {
                            FotoView(user: user)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding (.top, 15)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            if let images = user.userImages {
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
        .onAppear {
            deltaSubscription = 0
        }
    }
}

/*struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: users[0])
    }
}*/
