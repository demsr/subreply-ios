//
//  DiscoverView.swift
//  subreply
//
//  Created by Dennis Sumser on 23.07.25.
//

import SwiftUI


struct FeedPage : Decodable {
    let page: Int
    let entries: [FeedItem]
}

struct User: Decodable {
    let username: String
    let full_name: String
}

struct ParentItem: Decodable, Identifiable {
    let id: Int?
    let content: String?
    let timestamp: String?
    let created_by: User?
}

struct FeedItem: Decodable, Identifiable {
    let id: Int
    let content: String
    let timestamp: String
    let created_by: User
    var parent: ParentItem
}

struct DiscoverView: View {
    @StateObject private var feed = FeedViewModel()
   
    var body: some View {
       
            List(feed.items){ item in
                NavigationLink(destination: FeedItemView(feeditem: item)){
                    VStack{
                        HStack{
                            Text(item.created_by.username)
                            Text(item.timestamp)
                        }
                        Text(item.content)
                        
                    }
                }.onAppear{
                    feed.loadMoreContentIfNeeded(currentItem: item)
                }
              
            }
            .refreshable {
                feed.refresh()
            }
            .onAppear{
                if feed.items.isEmpty {
                    feed.loadMoreContentIfNeeded(currentItem: nil)
                }
            }
        
       
    }
}

#Preview {
    NavigationStack{
        DiscoverView().navigationTitle("Discover")
    }
    
}
