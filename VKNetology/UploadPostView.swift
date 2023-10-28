//
//  UploadPostView.swift
//  VKNetology
//
//  Created by Александр Филатов on 23.10.2023.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    
    
    @State private var caption = ""
    @State private var imagePickerPresented = false
    //@State private var photoItem: PhotosPickerItem?
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    /*init (user: User, tabIndex: Binding<Int>) {
        self._viewModel = StateObject(wrappedValue: UploadPostViewModel(user: user))
        self._tabIndex = tabIndex
   }*/
    
    
    
    
    
    var body: some View {
        VStack {
            
            
            HStack {
                
                Button {
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                    
                } label: {
                    Text ("Cancel")
                }
                Spacer()
                
                Text ("Добавить новый пост")
                    .fontWeight(.semibold)
                
                Spacer()
                Button {
                    print("Upload post")
                    
                    /*Task {
                        try await viewModel.uploadPost(caption:caption)
                        caption = ""
                        viewModel.selectedImage = nil
                        viewModel.postImage = nil
                        tabIndex = 0
                    }*/
                    viewModel.uploadPost(caption: caption) { success in
                        if success {
                            caption = ""
                            viewModel.selectedImage = nil
                            viewModel.postImage = nil
                            
                            
                            
                            tabIndex = 0
                            
                        }
                    }
                } label: {
                    Text ("Upload")
                }
                
            }
            .padding(.horizontal)
            if let image = viewModel.postImage {
                image
                    .resizable()
                    .scaledToFill()
                //.frame(width:UIScreen.main.bounds.width-40, height: 250)
                    .frame(height: 300, alignment: .top)
                    .clipped()
            }
            TextField("Добавьте текст поста...", text: $caption, axis: .vertical)
            
            
            Spacer()
        }
        .onAppear{
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

/*struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView( tabIndex: .constant(0))
    }
}*/
