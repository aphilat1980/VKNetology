//
//  FeedViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation
import Firebase


class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post] ()
    
    init () {
        Task {try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts () async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
}
