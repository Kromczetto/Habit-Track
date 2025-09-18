//
//  BottomMenuView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 18/09/2025.
//

import SwiftUI

struct BottomMenuView: View {
    @State private var index: Int = 0
    
    var body: some View {
        TabView(selection: $index) {
            NavigationView {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            NavigationView {
                AddNewHabitView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Add", systemImage: "plus.app.fill")
            }
            .tag(1)
            NavigationView {
                ProfileView()
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(2)
        }
    }
}

#Preview {
    BottomMenuView()
}
