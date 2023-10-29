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
    
    @StateObject var viewModel: PostViewModel
    @State var sheetIsPresented: Bool = false
    @State var deltaLikes: Int = 0
    
    init (post: Post) {
        self.post = post
        self._viewModel = StateObject(wrappedValue: PostViewModel(post: post))
    }
    
    var body: some View {
        
        VStack {
            HStack {
                if let user = post.author {
                    CircularProfileImageView(user: user, dimension: 60)
                }
                if let user = post.author {
                    if user.id != AuthService.shared.currentUser!.id {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            VStack (alignment: .leading) {
                                Text (user.userName)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                Text (user.userProfession ?? "")
                                    .foregroundColor(.black)
                            }
                            .padding(.leading)
                        }
                    } else {
                        VStack (alignment: .leading) {
                            Text (user.userName)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text (user.userProfession ?? "")
                                .foregroundColor(.black)
                        }
                        .padding(.leading)
                    }
                }
                Spacer()
            }
            .padding(.top, 15)
            
            VStack {
                KFImage(URL(string: post.postFoto))
                    .resizable()
                    .frame(height: 300, alignment: .top)
                    .clipped()
                
                Text (post.description)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                Divider()
                    .foregroundColor(.black)
                
                HStack {
                    if viewModel.isLiked {
                        Button {
                            Task {try await viewModel.removeLike()}
                            viewModel.isLiked.toggle()
                            deltaLikes -= 1
                        } label: {
                            Image (systemName: "heart.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    } else {
                        Button {
                            Task {try await viewModel.addLike()}
                            viewModel.isLiked.toggle()
                            deltaLikes += 1
                        } label: {
                            Image (systemName: "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    Text ("\(post.postLikes.count + deltaLikes)")
                    Spacer()
                    
                    if viewModel.isSaved {
                        Button {
                            Task {try await viewModel.deletePostFromSaved()}
                            viewModel.isSaved.toggle()
                        } label: {
                            Image (systemName: "bookmark.fill")
                                .resizable()
                                .frame(width: 15, height: 20)
                        }
                    } else {
                        Button {
                            Task {try await viewModel.savePost()}
                            viewModel.isSaved.toggle()
                        } label: {
                            Image (systemName: "bookmark")
                                .resizable()
                                .frame(width: 15, height: 20)
                        }
                    }
                    
                }
                .padding()
            }
            .background {
                Color(.secondarySystemBackground)
            }
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.isLiked = false
            viewModel.isSaved = false
            viewModel.fetchIfCurrentUserAlreadyLikedOrSavedPost()
            deltaLikes = 0
        }
    }
}

/*struct PostView_Previews: PreviewProvider {
 static var previews: some View {
 PostView()
 }
 }*/
