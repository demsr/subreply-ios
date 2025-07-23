//
//  MockData.swift
//  subreply
//
//  Created by Dennis Sumser on 23.07.25.
//

import Foundation


class MockData {
    
    func getFeedItem() -> FeedItem {
         FeedItem(id: 0, content: "Example Post", timestamp: "5m", created_by: User(username: "username", full_name: "fullname"), parent: ParentItem(id: 1, content: "Parent Post", timestamp: "1m", created_by: User(username: "username", full_name: "fullname")))
    }
}
