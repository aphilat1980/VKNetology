//
//  PostViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 28.10.2023.
//

import Foundation
import Firebase

class PostViewModel: ObservableObject {
    
    init (post: Post) {
        
        self.post = post
        fetchIfCurrentUserAlreadyLikedPost()
        
    }
    
    @Published var post: Post
    var isLiked: Bool = false
    
    func addLike () async throws {
        
        if let currentUser = Auth.auth().currentUser {
            try await Firestore.firestore().collection("posts").document(self.post.id).updateData(["postLikes": FieldValue.arrayUnion([currentUser.uid])])
        }
    }
    
    func removeLike () async throws {
        if let currentUser = Auth.auth().currentUser {
            
            try await Firestore.firestore().collection("posts").document(self.post.id).updateData(["postLikes": FieldValue.arrayRemove([currentUser.uid])])
            
        }
    }
    
    
    /*func fetchIfCurrentUserAlreadyLikesPost() async throws -> Bool {
     
     if let currentUser = Auth.auth().currentUser {
     
     let snapshot = try await Firestore.firestore().collection("posts").document(self.post.id).getDocument()
     let post = try snapshot.data(as: Post.self)
     if let likes = post?.postLikes {
     
     if likes.contains(currentUser.uid) {
     return true
     } else {
     return false
     }
     } else {
     return false
     }
     } else { return false}
     }*/
    
    /* func fetch () {
     //var res: Bool
     fetchIfCurrentUserAlreadyLikesPost { result in
     if let result {
     if result {
     self.isLiked = true
     
     } else {
     self.isLiked = false
     }
     
     }
     }
     
     }*/
    
    
    func fetchIfCurrentUserAlreadyLikedPost() {
        
        if let currentUser = Auth.auth().currentUser {
            
            Firestore.firestore().collection("posts").document(self.post.id).getDocument() { (doc, error) in
                if let doc {
                    do {
                        if let post = try doc.data(as: Post.self) {
                            if post.postLikes.contains(currentUser.uid) {
                                self.isLiked = true
                            }
                        }
                    } catch {return}
                }
            }
        }
    }
}
