//
//  CurrentUserProfileViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation
import Firebase


class ProfileViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var isSubscribed = false
    let user: User

    init (user: User) {
        self.user = user
        Task {try await fetchUserPosts() }
        Task {try await fetchSubscription() }
        
    }
    
    @MainActor
    func fetchUserPosts () async throws {
        self.posts = try await PostService.fetchUserPosts(uid: self.user.id)
    }
    
    
    func addSubcription () async throws {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("users").document(currentUser.uid).updateData(["subscription": FieldValue.arrayUnion([user.id])])
        try await Firestore.firestore().collection("users").document(user.id).updateData(["subscribers": FieldValue.arrayUnion([currentUser.uid])])
    }
    
    @MainActor
    func removeSubcription () async throws {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        try await Firestore.firestore().collection("users").document(currentUser.uid).updateData(["subscription": FieldValue.arrayRemove([user.id])])
        try await Firestore.firestore().collection("users").document(user.id).updateData(["subscribers": FieldValue.arrayRemove([currentUser.uid])])
    }
    
    @MainActor
    func fetchSubscription () async throws {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(currentUser.uid).getDocument()
        guard let curUser = try snapshot.data(as: User.self) else {return}
        if let subscription = curUser.subscription {
            if subscription.contains(user.id) {
                self.isSubscribed = true
            }
        }
    }
}
