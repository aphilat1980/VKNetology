//
//  EditProfileViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 11.10.2023.
//
import SwiftUI
import Foundation
import PhotosUI
import Firebase

@MainActor
class EditPofileViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    @Published var profileImage: Image?
    
    @Published  var fullname = ""
    @Published  var profession = ""
    
    private var uiImage: UIImage?
    
    init (user: User){
        self.user = user
       
        self.fullname = user.userName
        
        
        if let profession = user.userProfession {
            self.profession = profession
        }
    }
    
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
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
                //URLCache.shared.removeAllCachedResponses()
            
                data["userFoto"] = imageUrl!
                if !data.isEmpty {
                    print("DATA IS ...", data)
                    Firestore.firestore().collection("users").document(self.user.id).updateData(data)
                    
                }
                URLCache.shared.removeAllCachedResponses()
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
    
    
    func updateUserImageData(completion: @escaping (_ success: Bool) -> Void) {
        
        var data = [String: Any]()
            
        if let uiImage = uiImage {
            ImageUploader().uploadingImage(image: uiImage) {imageUrl in
                
                if let imageUrl = imageUrl {
                    data["userFoto"] = imageUrl
                    print("DATA IS ...", data)
                    Firestore.firestore().collection("users").document(self.user.id).updateData(data) {error in
                        
                        if error != nil {
                            completion (false)
                        } else {
                            completion (true)
                        }
                    }
                } else {
                    completion (false)
                }
            }
        }
        
        if !fullname.isEmpty && user.userName != fullname {
            user.userName = fullname
            data ["userName"] = fullname
        }
        
        if !profession.isEmpty && user.userProfession != profession {
           user.userProfession = profession
            //print(user.userProfession)
            data ["userProfession"] = profession
        }
        
        if !data.isEmpty {
            Firestore.firestore().collection("users").document(user.id).updateData(data) {error in
                
                if error != nil {
                    completion (false)
                } else {
                    completion (true)
                }
            }
        }
        
    }
    
    
}
    

