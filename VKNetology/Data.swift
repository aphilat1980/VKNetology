//
//  Data.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI
import Firebase


struct User: Identifiable, Codable {
    //Codable
    
    var id: String
    var userName: String
    var userFoto: String?
    var userProfession: String?
    var email: String
    
    //var email
}


struct Post: Identifiable, Codable {
    
    var id: String
    var author: User
    //?
    var description: String
    var postFoto: String
    var postLikes: Int
    var postMessages: Int
    var hasBookmarked: Bool = false
    var postDate: Timestamp
    
}

//сделано как расширение к структуре users
var users = [User(id: "1", userName: "Alex", userFoto: "alexFoto", userProfession: "Designer", email: "aghg@gmail.com"),
             User(id: "2", userName: "Angela", userFoto: "angelaFoto", userProfession: "Actor",  email: "aghg@gmail.com"),
             User(id: "3", userName: "Bobby", userFoto: "bobbyFoto", userProfession: "Musician",  email: "aghg@gmail.com")


]

var storiesDatabase = [users[0], users[1], users[2], users[0]]


var postsDatabase = [Post(id: "1", author: users[0], description: "fgfgfgfgfgfgfgfgfgfg fgfg hjhjhj hfgfhj gfgfgfgfg  ghghghghg  hjhjhjhj hjhjhjhj hjhjhjhjhj hjhjhjhjh hjhjhjhjhj hjhjhjhjhj hjhjhjhjh jhjhjhjhj hjhjhjhjhjh ghghghghgh ghghghghgh ghghghghgh ghghghgh ghghghghgh", postFoto: "post1Foto", postLikes: 10, postMessages: 20, postDate: Timestamp()),
                     Post(id: "2", author: users[1], description: "fgfgfgfgfgfgfgfgfgfgfgfg", postFoto: "post2Foto", postLikes: 10, postMessages: 20, postDate: Timestamp()),
                     Post(id: "3", author: users[2], description: "fgfgfgfgfgfgfgfgfgfgfgfg", postFoto: "post1Foto", postLikes: 10, postMessages: 1000, postDate: Timestamp()),
                     Post(id: "4", author: users[1], description: "fgfgfgfgfgfgfgfgfgfgfgfg", postFoto: "post1Foto", postLikes: 10, postMessages: 20, postDate: Timestamp()),
]

                       
                       

