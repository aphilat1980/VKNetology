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
        //self.userSession = Auth.auth().currentUser
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
            print("create user")
            await uploadUserData(uid: result.user.uid, username: userName, email: email)
            print ("upload user data")
        } catch {
            print("error \(error.localizedDescription)")
        }
        
        
    }
    @MainActor
    func loadUserData () async throws {
        
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else {return}
        print ("loading...")
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        //print(snapshot.data())
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    
    func sighOut () {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
   //@MainActor
    func uploadUserData (uid: String, username: String, email: String) async {
        
        let user = User(id: uid, userName: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
}
