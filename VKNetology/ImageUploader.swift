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
    
    /*static func uploadingImage(image: UIImage) async throws -> String? {
        
         guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
         
         let filename = NSUUID().uuidString
         let ref = Storage.storage().reference(withPath: "/profile_images/\(filename )")
         
        
        //let meta = ref.putData(imageData)
        
             
        do {
         let _ = await ref.putDataAsync(imageData)
         let url = try await ref.downloadURL()
            print ("urL = \(url)")
         return url.absoluteString
         } catch {
         print ("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
         return nil
         }
         
         }*/
    //func requestResidentName (url: String, completion: @escaping (_ name: String)-> Void)
    
    func uploadingImage(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
            
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print ("error jpg")
                completion (nil)
                return
            }
            let filename = NSUUID().uuidString
            let ref = Storage.storage().reference(withPath: "/profile_images/\(filename )")
            
            let uploadTask = ref.putData(imageData, metadata: nil) { (metadata, error) in
                
                if let metadata = metadata {
                    print(metadata.size)
                    
                    ref.downloadURL { url, error in
                        if let url {
                            print(url.absoluteString)
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
    
    
    

