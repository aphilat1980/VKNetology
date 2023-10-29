//
//  UserService.swift
//  VKNetology
//
//  Created by Александр Филатов on 27.10.2023.
//

import Foundation
import Firebase


struct UserService {
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)!
    }
}
