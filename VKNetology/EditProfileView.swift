//
//  EditProfileView.swift
//  VKNetology
//
//  Created by Александр Филатов on 10.10.2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    //@State private var selectedImage: PhotosPickerItem?
    //@State private var fullname = ""
    //@State private var bio = ""
    @StateObject var viewModel: EditPofileViewModel
    
    init (user: User) {
        self._viewModel = StateObject(wrappedValue: EditPofileViewModel(user: user))
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text ("Изменить профиль")
                
                Spacer()
                
                Button {
                    /*Task {try await viewModel.updateUserData()
                        try await AuthService.shared.loadUserData()
                        dismiss()*/
                    viewModel.updateUserImageData { success in
                        if success {
                            print ("success")
                            AuthService.shared.loadUserImageData {success in
                                if success {
                                    dismiss()
                                } else {
                                    print ("dont load user data")
                                }
                            }
                        } else {
                            print ("failure")
                            
                    }
                    }
                } label: {
                    Text ("Done")
                }
                
            }
            .padding()
            
            Divider()
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80, alignment: .top)
                            .clipShape(Circle())
                        
                    } else {
                        
                        /*Image(systemName: "person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80, alignment: .top)
                        .clipShape(Circle())*/
                        CircularProfileImageView(user: viewModel.user, dimension: 80)
                        
                    }
                    
                    Text ("Edit profile picture")
                        .font(.footnote)
                    
                    Divider()
                }
            }
            
            VStack {
                
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Profession", placeholder: "Enter your profession", text: $viewModel.profession)
                
            }
            Spacer()
            
        }
        
        
        
    }
}


struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        
        HStack {
            
            Text (title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                Divider()
            }
            
        }
    }
    
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: users[0])
    }
}
