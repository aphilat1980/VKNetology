//
//  RegisterView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI

struct RegisterView: View {
    
    //@State var phoneNumber: String = ""
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        //NavigationView {
            
            
            VStack () {
                
                Text ("ЗАРЕГИСТРИРОВАТЬСЯ")
                    .fontWeight(.bold)
                    .padding(.bottom, 50)
                
                Text ("Введите номер")
                    .foregroundColor(.gray)
                Text ("Ваш номер будет использоваться\n для входа в аккаунт")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 5)
                
                TextField("Enter email", text: $viewModel.email)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))
                    .padding(.horizontal, 30)
                
                TextField("Create User Name", text: $viewModel.userName)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))
                    .padding(.horizontal, 30)
                
                TextField("Set password", text: $viewModel.password)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))
                    .padding(.horizontal, 30)
                
                Button {
                    
                    Task {try await viewModel.createUser()}
                    
                } label: {
                    Text("ДАЛЕЕ")
                        .padding(20)
                        .padding(.horizontal,30)
                        .foregroundColor(.white)
                        .background {
                            Color.gray.cornerRadius(20)
                        }
                }
                .padding(.vertical, 20)

                
                
                /* NavigationLink {
                    
                    TabBarView()
                    
                } label: {
                    Text("ДАЛЕЕ")
                        .padding(20)
                        .padding(.horizontal,30)
                        .foregroundColor(.white)
                        .background {
                            Color.gray.cornerRadius(20)
                        }
                }
                .padding(.vertical,20)*/
                
                Text ("Нажимая кнопку Далее Вы принимаете пользовательское соглашение и политику конфиденциальности")
                    .multilineTextAlignment(.center)
            
                    
                
                    
                
                
                
           // }
            
        
            
        }
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
