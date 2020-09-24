//
//  FetchFeedsRequest.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

struct FetchFeedsRequestResponse: Codable {
    var title: String
    let rows: [Feed]?
}

struct FetchFeedsRequest: APIEndpoint, Codable {
    
    //
    // Better to provide raw string unless it shares a common base url.
    // In that case the base url can be added to string constants.
    //
    func endpoint() -> String {
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
    func dispatch(
        onSuccess successHandler: @escaping ((_: FetchFeedsRequestResponse) -> Void),
        onFailure failureHandler: @escaping ((_: Error) -> Void)) {
        
        NetworkClient.get(
            request: self,
            onSuccess: successHandler,
            onError: failureHandler)
    }
}
