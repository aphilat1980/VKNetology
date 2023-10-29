//
//  AuthService.swift
//  VKNetology
//
//  Created by Александр Филатов on 09.10.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    static let shared = AuthService()
    
    init () {
        Task {try await loadUserData()}
    }
    
    @MainActor
    func login (withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: error login \(error.localizedDescription)")
        }
        
    }
    @MainActor
    func createUser(email: String, password: String, userName: String) async throws {
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, username: userName, email: email)
        } catch {
            print("error \(error.localizedDescription)")
        }
        
        
    }
    @MainActor
    func loadUserData () async throws {
        
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser = try? snapshot.data(as: User.self)
    
        
    }
    
    func loadUserImageData (completion: @escaping (_ success: Bool) -> Void) {
        
        guard let currentUser else {return}
        Firestore.firestore().collection("users").document(currentUser.id).getDocument() {(doc, error) in
            if let doc {
                do {
                    self.currentUser = try doc.data(as: User.self)
                    completion(true)
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func sighOut () {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    func uploadUserData (uid: String, username: String, email: String) async {
        
        let user = User(id: uid, userName: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
}
