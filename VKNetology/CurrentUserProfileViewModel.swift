//
//  CurrentUserProfileViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 24.10.2023.
//

import Foundation


class CurrentUserProfileViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    let user: User
    
    
    init (user: User) {
        self.user = user
        Task {try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts () async throws {
        
        self.posts = try await PostService.fetchUserPosts(user: self.user)
        
    }
    
    
    
}
