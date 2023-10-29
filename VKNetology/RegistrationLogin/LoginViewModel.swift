//
//  LoginViewModel.swift
//  VKNetology
//
//  Created by Александр Филатов on 09.10.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func sighInUser() async throws {
       try await AuthService.shared.login(withEmail: email, password: password)
    }
}
