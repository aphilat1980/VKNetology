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
        
        /*let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        self.posts = try snapshot.documents.compactMap({ document in
            let post = try document.data(as: Post.self)
            return post
        })*/
        
        self.posts = try await PostService.fetchFeedPosts()
        
    }
    
}
