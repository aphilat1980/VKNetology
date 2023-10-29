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
        fetchIfCurrentUserAlreadyLikedOrSavedPost()
    }
    
    @Published var post: Post
    @Published var isLiked: Bool = false
    @Published var isSaved: Bool = false
    
    func addLike () async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("posts").document(self.post.id).updateData(["postLikes": FieldValue.arrayUnion([currentUser.uid])])
    }
    
    func removeLike () async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("posts").document(self.post.id).updateData(["postLikes": FieldValue.arrayRemove([currentUser.uid])])
    }
    
    
    func fetchIfCurrentUserAlreadyLikedOrSavedPost() {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        Firestore.firestore().collection("posts").document(self.post.id).getDocument() { (doc, error) in
            if let doc {
                do {
                    if let post = try doc.data(as: Post.self) {
                        if post.postLikes.contains(currentUser.uid) {
                            self.isLiked = true
                        }
                        if post.postSaved.contains(currentUser.uid) {
                            self.isSaved = true
                        }
                    }
                } catch {return}
            }
        }
    }
    
    func savePost () async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("posts").document(post.id).updateData(["postSaved": FieldValue.arrayUnion([currentUser.uid])])
    }
    
    func deletePostFromSaved () async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("posts").document(post.id).updateData(["postSaved": FieldValue.arrayRemove([currentUser.uid])])
    }
}
