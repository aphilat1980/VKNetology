//
//  CircularProfileImageView.swift
//  VKNetology
//
//  Created by Александр Филатов on 19.10.2023.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    
    let user: User
    let dimension: CGFloat
    
    var body: some View {
        
        if let imageUrl = user.userFoto {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: dimension, height: dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
    }
}

/*struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: users[0], dimension: 60)
    }
}*/
