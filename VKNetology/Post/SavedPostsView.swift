//
//  SavedPostsView.swift
//  VKNetology
//
//  Created by Александр Филатов on 29.10.2023.
//

import SwiftUI

struct SavedPostsView: View {
    
    @StateObject var viewModel = SavedPostsViewModel()
    
    var body: some View {
        
        ScrollView {
            Text ("Сохраненные посты")
            ForEach (viewModel.posts) {post in
                PostView(post: post)
            }
        }
        .onAppear {
            viewModel.posts = []
            Task {try await viewModel.fetchSavedPosts()}
        }
    }
}

struct SavedPostsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPostsView()
    }
}
