//
//  ProfileViewViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 25.10.2023.
//

import Foundation

class ProfileViewViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task {try await fetchUserPosts()}
    }
    
    @MainActor
    func fetchUserPosts () async throws {
        
        self.posts = try await PostService.fetchUserPosts(user: self.user)
        
    }
    
    
    
}
