//
//  FotoView.swift
//  VKNetology
//
//  Created by Александр Филатов on 08.10.2023.
//

import SwiftUI

struct FotoView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5)
    ]
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                Divider()
                
                LazyVGrid(columns: gridItems, spacing: 5) {
                    ForEach (0...15, id: \.self) {index in
                        
                        Image("post1Foto")
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(20)
                    }
                    
                    
                }
                
                
            }
            
            .padding()
            .navigationTitle("Фотографии")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FotoView_Previews: PreviewProvider {
    static var previews: some View {
        FotoView()
    }
}
