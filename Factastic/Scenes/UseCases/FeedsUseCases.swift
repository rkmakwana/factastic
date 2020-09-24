//
//  FeedsUseCases.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

typealias FetchFeedsCompletionHandler = (_ response: FetchFeedsRequestResponse?, _ error: Error?) -> Void

protocol FeedsUseCases {
    func fetchFeeds(completionHandler: @escaping FetchFeedsCompletionHandler)
}
