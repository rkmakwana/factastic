//
//  FeedsTableCellMock.swift
//  FactasticTests
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import Factastic

class FeedsTableCellMock: FeedsCellView {
    var displayedFeed: Feed?
    
    func configure(with feed: Feed) {
        displayedFeed = feed
    }
    
}
