//
//  UploadPostViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 23.10.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
        
    }
    
    func uploadPost (caption: String, completion: @escaping (_ success: Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else {return}
        ImageUploader().uploadingImage(image: uiImage) {imageURL in
            
            if let imageURL = imageURL {
                let postRef = Firestore.firestore().collection("posts").document()
                let post = Post(id: postRef.documentID, ownerId: uid, description: caption, postFoto: imageURL, postLikes: [], postSaved: [], postDate: Timestamp())
                guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
                postRef.setData(encodedPost) {error in
                    if let error = error {
                        print ("error is \(error)")
                        completion(false)
                    } else {
                        completion (true)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
}
