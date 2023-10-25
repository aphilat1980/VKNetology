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
                    Label("Главная", image: "houseTab")
                }.tag(0)
            CurrentUserProfileView(user: user)
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Label("Профиль", image: "userTab")
                }.tag(1)
            UploadPostView(user: user, tabIndex: $selectedIndex)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Label("Добавить", systemImage: "plus.app")
                }.tag(2)
            
            MainView()
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem {
                    Label("Сохраненные", image: "likeTab")
                }.tag(3)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(user: users[0])
    }
}
