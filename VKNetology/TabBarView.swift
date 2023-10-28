//
//  TabBarView.swift
//  VKNetology
//
//  Created by Александр Филатов on 02.10.2023.
//

import SwiftUI

struct TabBarView: View {
    
    let user: User
    @State private var selectedIndex = 0
    
    var body: some View {
        
        TabView (selection: $selectedIndex) {
            
            MainView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Label("Посты", systemImage: "house")
                }.tag(0)
            CurrentUserProfileView(user: user)
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }.tag(1)
            UploadPostView(tabIndex: $selectedIndex)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Label("Добавить пост", systemImage: "plus.app")
                }.tag(2)
            
           /* MainView()
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem {
                    Label("Сохраненные", image: "likeTab")
                }.tag(3)*/
        }
        .accentColor(.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(user: users[0])
    }
}
