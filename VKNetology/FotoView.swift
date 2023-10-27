//
//  FotoView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct FotoView: View {
    
    @State private var imagePickerPresented = false
    
    @State private var deleteButtonPresented = false
    
    var user: User
    
    @StateObject var viewModel: FotoViewModel
    
    @State var deletingImageUrl: String?
    
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5)
    ]
    
    init (user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FotoViewModel(user: user))
    }
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                HStack {
                    if deleteButtonPresented, user.id == AuthService.shared.currentUser?.id {
                        
                        Button("Удалить фото") {
                            if let deletingImageUrl = deletingImageUrl {
                                viewModel.deleteUserImage(image: deletingImageUrl)
                                deleteButtonPresented = false
                            }
                        }
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    if user.id == AuthService.shared.currentUser?.id {
                        Button("Добавить фото") {
                            self.imagePickerPresented.toggle()
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                LazyVGrid(columns: gridItems, spacing: 5) {
                    
                    
                    if let images = user.userImages {
                        
                        ForEach (images, id: \.self) { imageUrl in
                            
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .scaledToFill()
                                .onTapGesture {
                                    deletingImageUrl = imageUrl
                                    deleteButtonPresented.toggle()
                                }
                                
                                
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            .padding(.horizontal)
            .navigationTitle("Фотографии")
            .navigationBarTitleDisplayMode(.inline)
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

/*struct FotoView_Previews: PreviewProvider {
    static var previews: some View {
        FotoView()
    }
}*/
