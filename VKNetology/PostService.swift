//
//  PostService.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation
import Firebase


struct PostService {
    
    /*static func fetchFeedPosts(completion: @escaping (_ posts: [Post]?) -> Void) {
        
        Firestore.firestore().collection("posts").getDocuments { (doc, error) in
            if let doc {
                do {
                    
                    var posts = try doc.documents.compactMap({try $0.data(as: Post.self)})
                    var postsWithUsers: [Post] = []
                        for i in 0..<posts.count {
                            var post = posts[i]
                            let ownerId = post.ownerId
                            UserService.fetchUser(withUid: ownerId) {user in
                                if let user {
                                    posts[i].author = user
                                    postsWithUsers.append(posts[i])
                                    completion(postsWithUsers)
                                }
                                
                            }
                        }
                    //completion(postsWithUsers)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
    }*/
    
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
            var post = posts[i]
            let ownerId = post.ownerId
            let postUser = try await UserService.fetchUser(withUid: ownerId)
            posts[i].author = postUser
        }
        
        return posts
        
    }
    
}
