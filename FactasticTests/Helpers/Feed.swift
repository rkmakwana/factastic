//
//  Feed.swift
//  FactasticTests
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import Factastic

extension Feed {
    
    static func createFeedList(numberOfItems: Int) -> [Feed] {
        var feeds = [Feed]()
        for i in 0..<numberOfItems {
            do {
                try feeds.append(createFeed(id: i))
            } catch { }
        }
        return feeds
    }
    
    static func createFeed(id: Int) throws -> Feed {
        let jsonFeed = [
            "title": "Title \(id)",
            "description": "Description \(id)",
            "imageHref": "http://path.to.image/\(id)"
        ]
        let data = try JSONSerialization.data(withJSONObject: jsonFeed, options: .prettyPrinted)
        let feed = try JSONDecoder().decode(Feed.self, from: data)
        return feed
    }
    
    static func createEmptyFeed() throws -> Feed {
        let jsonFeed = [
            "title": nil,
            "description": nil,
            ] as [String : Any?]
        let data = try JSONSerialization.data(withJSONObject: jsonFeed, options: .prettyPrinted)
        let feed = try JSONDecoder().decode(Feed.self, from: data)
        return feed
    }
    
    
    
}
