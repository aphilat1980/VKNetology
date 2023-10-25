//
//  StoryView.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI

struct StoryView: View {
    
    
    var imageName = "alexFoto"
    var userName = "Alex"
    
    var body: some View {
        
        VStack {
            
            VStack {
                Image (imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(30)
            }
            .overlay {
                Circle()
                    .stroke(Color(.orange), lineWidth: 2)
            }
            
            Text (userName)
                .font(.caption)
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
