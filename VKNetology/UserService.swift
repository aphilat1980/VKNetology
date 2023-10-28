//
//  UserService.swift
//  VKNetology
//
//  Created by Александр Филатов on 27.10.2023.
//

import Foundation
import Firebase


struct UserService {
    
    
    /*static func fetchUser(withUid uid: String, completion: @escaping (_ posts: User?) -> Void) {
    
        
        Firestore.firestore().collection("users").document(uid).getDocument {(doc, error) in
            if let doc {
                do {
                    let user = try doc.data(as: User.self)
                    completion(user)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
            
        }
    }*/
    
    
    static func fetchUser(withUid uid: String) async throws -> User {
    
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)!
        
    }
    
    
}
