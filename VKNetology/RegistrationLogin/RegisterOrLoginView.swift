//
//  RegisterOrLoginView.swift
//  VKNetology
//
//  Created by Александр Филатов on 09.10.2023.
//

import SwiftUI

struct RegisterOrLoginView: View {
    
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        
        NavigationView {
            VStack {
                Image("Image")
                NavigationLink {
                RegisterView()
                    .environmentObject(registrationViewModel)
                } label: {
                    Text("ЗАРЕГИСТРИРОВАТЬСЯ")
                        .padding(20)
                        .foregroundColor(.white)
                        .background {
                            Color.gray.cornerRadius(30)
                        }
                }
                
                NavigationLink {
                    LogInView()
                } label: {
                    Text ("Уже есть аккаунт")
                        .padding(20)
                }
            }
            .padding()
        }
    }
}
        

struct RegisterOrLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterOrLoginView()
    }
}
