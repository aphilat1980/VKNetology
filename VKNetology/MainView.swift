//
//  MainView.swift
//  VKNetology
//
//  Created by Александр Филатов on 02.10.2023.
//

import SwiftUI


struct MainView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                StoriesView()
                
                
                ForEach(viewModel.posts) {post in
                    
                    PostView(post: post)
                    
                }
                
                
                
            }
        }
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
