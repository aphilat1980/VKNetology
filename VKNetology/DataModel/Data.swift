//
//  Data.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI
import Firebase


struct User: Identifiable, Codable {
    var id: String
    var userName: String
    var userFoto: String?
    var userProfession: String?
    var email: String
    var userImages: [String]?
    var subscribers: [String]?
    var subscription: [String]?
}


struct Post: Identifiable, Codable {
    var id: String
    var author: User?
    var ownerId: String
    var description: String
    var postFoto: String
    var postLikes: [String]
    var postSaved: [String]
    var postDate: Timestamp
}

                       
                       

