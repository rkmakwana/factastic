//
//  Feed.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class Feed: Codable {
    private let title: String?
    private let description: String?
    
    let imageHref: String?
    
    public var topic: String {
        if let topic = title {
            return topic
        } else {
            return "Untitled"
        }
    }
    
    public var detail: String {
        if let detail = description {
            return detail
        } else {
            return "No description provided"
        }
    }
}
