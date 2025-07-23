//
//  FeedItemView.swift
//  subreply
//
//  Created by Dennis Sumser on 23.07.25.
//

import SwiftUI

struct FeedItemView: View {
    
    @State var feeditem : FeedItem
    
    
    var body: some View {
        VStack{
            Text(feeditem.content)
            Text(feeditem.timestamp)
            Text(feeditem.created_by.username)
        }
    }
}

#Preview {
    
    var mock = MockData()
    
    FeedItemView(feeditem: mock.getFeedItem())
}
