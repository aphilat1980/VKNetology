//
//  FotoViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 25.10.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase


class FotoViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {loadImage(fromItem: selectedImage)}
    }
    
    private var uiImage: UIImage?
    
    @Published var user: User
    
    init (user: User){
        self.user = user
    }
    
    
    //@MainActor
    func loadImage(fromItem item: PhotosPickerItem?) {
        guard let item = item else {return}
        item.loadTransferable(type: Data.self) { result in
            switch result {
                
            case .success(let data):
                if let data = data {
                    guard let uiImage = UIImage(data: data) else {return}
                    self.uiImage = uiImage
                    self.updateUserData { success in
                        if success {
                            AuthService.shared.loadUserImageData { success in
                                if success == false {return}
                            }
                        } else {
                            return
                        }
                    }
                    
                }
                
            case .failure(let error):
                print (error.localizedDescription)
                    return
            }
                
            }
        }
    
    
    
    /*@MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async throws {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        try await updateUserData()
        //self.profileImage = Image(uiImage: uiImage)
        //try await AuthService().loadUserData()
        
       //try await loadUser()
        
    }*/
    
    func updateUserData(completion: @escaping (_ success: Bool) -> Void) {
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            ImageUploader().uploadingImage(image: uiImage) {imageUrl in
                if let imageUrl {
                    data["userImages"] = [imageUrl]
                    Firestore.firestore().collection("users").document(self.user.id).updateData(["userImages": FieldValue.arrayUnion([imageUrl])]) {error in
                        
                        if error != nil {
                            completion (false)
                        } else {
                            completion (true)
                        }
                    }
                } else {
                    completion(false)
                    return
                }
            }
        }
    }
    
    
    func deleteUserImage (image: String) {
        
        Firestore.firestore().collection("users").document(self.user.id).updateData(["userImages": FieldValue.arrayRemove([image])]) {error in
            
            if error != nil {
                return
            } else {
                AuthService.shared.loadUserImageData { success in
                    if success == false {return}
                }
            }
        }
        
        
    }
}
    
    

/*import Foundation
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    @Published var user: User
    
    @Published var postImage: Image?
    
    private var uiImage: UIImage?
    
    init (user: User){
        self.user = user
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
        
    }
    
    /*func uploadPost (caption: String) async throws {
        
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let uiImage = uiImage else {return}
        
        ImageUploader().uploadingImage(image: uiImage) {imageURL in
            let postRef = Firestore.firestore().collection("posts").document()
            
            let post = Post(id: postRef.documentID, author: self.user, description: caption, postFoto: imageURL!, postLikes: 0, postMessages: 0, postDate: Timestamp())
            
            guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
            
           postRef.setData(encodedPost)
            
        }*/
        
        //let post = Post(id: 1, author: user, description: caption, postFoto: "", postLikes: 0, postMessages: 0, postDate: Timestamp())
    
    func uploadPost (caption: String, completion: @escaping (_ success: Bool) -> Void) {
        
        //guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let uiImage = uiImage else {return}
        
        ImageUploader().uploadingImage(image: uiImage) {imageURL in
            
            if let imageURL = imageURL {
                let postRef = Firestore.firestore().collection("posts").document()
                
                let post = Post(id: postRef.documentID, author: self.user, description: caption, postFoto: imageURL, postLikes: 0, postMessages: 0, postDate: Timestamp())
                
                guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
                
               //postRef.setData(encodedPost)
                postRef.setData(encodedPost) {error in
                    if let error = error {
                        print ("error is \(error)")
                        completion(false)
                    } else {
                        print("--TRUE SET DATA--")
                        completion (true)
                    }
                }
            } else {
                completion(false)
            }
            
        }
    
        
    }
    
}*/

/*func updateUserData() async throws {
    
    var data = [String: Any]()
    
    
        //let imageUrl = try? await ImageUploader.uploadingImage(image: uiImage)
        
        
        if !fullname.isEmpty && user.userName != fullname {
            user.userName = fullname
            print(user.userName)
            data ["userName"] = fullname
        }
        
        if !profession.isEmpty && user.userProfession != profession {
           user.userProfession = profession
            //print(user.userProfession)
            data ["userProfession"] = profession
        }
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
        if let uiImage = uiImage {
        ImageUploader().uploadingImage(image: uiImage) {imageUrl in
            //self.user.userFoto = imageUrl
            //print("url IS \(imageUrl!)")
            data["userFoto"] = imageUrl!
            if !data.isEmpty {
                print("DATA IS ...", data)
                Firestore.firestore().collection("users").document(self.user.id).updateData(data)
                
            }
            //Firestore.firestore().collection("users").document(self.user.id).updateData(data)
            //print(data["profileImageUrl"]!)
            
        }
        //data["profileImageUrl"] = imageUrl
    }
    
    /*if !fullname.isEmpty && user.userName != fullname {
        user.userName = fullname
        print(user.userName)
        data ["userName"] = fullname
    }
    
    if !profession.isEmpty && user.userProfession != profession {
       user.userProfession = profession
        //print(user.userProfession)
        data ["profession"] = profession
    }*/
    
    /*if !data.isEmpty {
        print("DATA IS ...", data)
        try await Firestore.firestore().collection("users").document(user.id).updateData(data)
    }*/
    
}*/

