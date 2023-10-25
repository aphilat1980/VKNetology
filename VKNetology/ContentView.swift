//
//  ContentView.swift
//  VKNetology
//
//  Created by Александр Филатов on 09.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        
        Group {
            
            if viewModel.userSession == nil {
                
                RegisterOrLoginView()
            } else if let currentUser = viewModel.currentUser {
                
                TabBarView(user: currentUser)
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
