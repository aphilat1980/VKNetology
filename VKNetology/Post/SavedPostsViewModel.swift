//
//  SavedPostsViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 29.10.2023.
//

import Foundation
import Firebase

class SavedPostsViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    @MainActor
    func fetchSavedPosts () async throws {
        print (posts)
        guard let currentUser = Auth.auth().currentUser else {return}
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        let allPosts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        
        for post in allPosts {
            
            for i in post.postSaved {
                if i == currentUser.uid {
                    var postWithAuthor = post
                    let ownerId = post.ownerId
                    let postAuthor = try await UserService.fetchUser(withUid: ownerId)
                    postWithAuthor.author = postAuthor
                    self.posts.append(postWithAuthor)
                }
            }
        }
    }
}
