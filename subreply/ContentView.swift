//
//  ContentView.swift
//  subreply
//
//  Created by Dennis Sumser on 23.07.25.
//

import SwiftUI

enum TabItem: String, CaseIterable {
    case discover = "Discover"
    case feed = "Feed"
    case settings = "Settings"
}

struct ContentView: View {
    
    @State private var selectedTab: TabItem = .discover
    
    
    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab){
                DiscoverView()
                    .tag(TabItem.discover)
                    .tabItem {
                        Label("Discover", systemImage: "globe")
                    }

                Text("Feed")
                    .tag(TabItem.feed)
                    .tabItem {
                        Label("Feed", systemImage: "tray.and.arrow.down.fill")
                    }

                Text("Messages")
                    .tag(TabItem.settings)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }.toolbar{
                Text("Sign in")
            }.navigationTitle(selectedTab.rawValue)
        }
       
    }
}

#Preview {
    ContentView()
}
