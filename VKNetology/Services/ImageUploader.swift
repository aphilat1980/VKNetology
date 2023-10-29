//
//  ImageUploader.swift
//  VKNetology
//
//  Created by Александр Филатов on 17.10.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage


struct ImageUploader {
    
    
    func uploadingImage(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion (nil)
            return
        }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename )")
        
        _ = ref.putData(imageData, metadata: nil) { (metadata, error) in
            
            if metadata != nil {
                ref.downloadURL { url, error in
                    if let url {
                        completion(url.absoluteString)
                    } else if let error {
                        print ("download url error \(String(describing: error.localizedDescription))")
                        completion(nil)
                    }
                }
                
            } else {
                print ("Error while uploading")
                completion(nil)
            }
        }
    }
}




