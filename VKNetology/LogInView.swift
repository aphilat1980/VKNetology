//
//  LogInView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI

struct LogInView: View {
    
    //@State var phoneNumber: String = ""
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        VStack {
            
          Text ("С возвращением")
                .foregroundColor(.orange)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            Text ("Введите номер телефона \n для входа в приложение")
                .multilineTextAlignment(.center)
            
            TextField("Enter email", text: $viewModel.email)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1))
                .padding(.horizontal, 30)
            
            TextField("Enter password", text: $viewModel.password)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1))
                .padding(.horizontal, 30)
            
            /*NavigationLink {
                
                TabBarView()
                
            } label: {
                Text("ПОДТВЕРДИТЬ")
                    .padding(20)
                    .padding(.horizontal,30)
                    .foregroundColor(.white)
                    .background {
                        Color.gray.cornerRadius(20)
                    }
            }
            .padding(.top, 70)*/
            Button {
                
                Task {try await viewModel.sighInUser()}
                
            } label: {
                Text("ПОДТВЕРДИТЬ")
                    .padding(20)
                    .padding(.horizontal,30)
                    .foregroundColor(.white)
                    .background {
                        Color.gray.cornerRadius(20)
                    }
            }
            .padding(.top, 70)

            
            
            
            
        }
        
        
        
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
