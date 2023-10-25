//
//  RegistrationViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 09.10.2023.
//

import Foundation


class RegistrationViewModel: ObservableObject {
    
    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        
       try await AuthService.shared.createUser(email: email, password: password, userName: userName)
    }
    
    
    
}
