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

