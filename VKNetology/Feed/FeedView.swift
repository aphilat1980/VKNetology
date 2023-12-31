//
//  MainView.swift
//  VKNetology
//
//  Created by Александр Филатов on 02.10.2023.
//

import SwiftUI


struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    HStack{
                        Text ("Пользователь:  ")
                        Text (AuthService.shared.currentUser?.userName ?? "")
                            .fontWeight(.bold)
                    }
                    
                    ForEach(viewModel.posts) {post in
                        PostView(post: post)
                    }
                }
            }
        }
        .onAppear {
            Task {try await viewModel.fetchPosts()}
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
