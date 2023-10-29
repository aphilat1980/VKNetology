//
//  PostService.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation
import Firebase


struct PostService {
    
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await Firestore.firestore().collection("posts").whereField("ownerId", isEqualTo: uid).getDocuments()
        let posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        return posts
    }
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts = try snapshot.documents.compactMap({ document in
            let post = try document.data(as: Post.self)
            return post
        })
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerId = post.ownerId
            let postUser = try await UserService.fetchUser(withUid: ownerId)
            posts[i].author = postUser
        }
        return posts
    }
}
