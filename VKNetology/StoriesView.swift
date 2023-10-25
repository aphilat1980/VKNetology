//
//  StoriesView.swift
//  VKNetology
//
//  Created by Александр Филатов on 03.10.2023.
//

import SwiftUI

struct StoriesView: View {
    var body: some View {
       
        ScrollView (.horizontal, showsIndicators: false) {
            
            HStack {
                
                ForEach(storiesDatabase) {person in
                    
                    StoryView(imageName: person.userFoto ?? "", userName: person.userName)
                        .onTapGesture {
                            print(person.userName)
                        }
                    
                }
                
                
                
            }
            .padding(20)
            
        }
        
        
        
        
        
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
