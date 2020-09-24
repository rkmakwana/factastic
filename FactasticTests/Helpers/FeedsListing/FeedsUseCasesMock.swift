//
//  FeedsUseCasesMock.swift
//  FactasticTests
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
@testable import Factastic

class FeedsUseCasesMock: FeedsUseCases {
    var responseToBeReturned: FetchFeedsRequestResponse?
    var errorToReturn: Error?
    
    func fetchFeeds(completionHandler: @escaping FetchFeedsCompletionHandler) {
        completionHandler(responseToBeReturned, errorToReturn)
    }

}
