//
//  PostService.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation
import Firebase


struct PostService {
    
    static func fetchFeedPosts() async throws -> [Post] {
        
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts = try snapshot.documents.compactMap({ document in
            let post = try document.data(as: Post.self)
            return post
        })
        return posts
        
    }
    
    static func fetchUserPosts(user: User) async throws -> [Post] {
        
        let snapshot = try await Firestore.firestore().collection("posts").whereField("author.id", isEqualTo: user.id).getDocuments()
        
            let posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        
            return posts
       
        //return posts
        
        
        
        
    }
    
}
