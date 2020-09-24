//
//  FeedsUseCasesImplementation.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class FeedsUseCasesImplementation: FeedsUseCases {
    
    func fetchFeeds(completionHandler: @escaping FetchFeedsCompletionHandler) {
        FetchFeedsRequest().dispatch(onSuccess: { result in
            completionHandler(result, nil)
        }) { err in
            completionHandler(nil, err)
        }
    }
    
}
