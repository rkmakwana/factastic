//
//  NetworkClient.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

protocol APIEndpoint {
    func endpoint() -> String
}

class NetworkClient {
    
    enum APIError: Error {
        case invalidEndpoint
        case decodingError
        case noData
    }
    
    // MARK:- Create URL Request
    
    public static func urlRequest(from request: APIEndpoint) -> URLRequest? {
        let endpoint = request.endpoint()
        guard let endpointUrl = URL(string: endpoint) else {
            return nil
        }
        
        let endpointRequest = URLRequest(url: endpointUrl)
        return endpointRequest
    }
    
    // MARK:- GET
    
    public static func get<R: Codable & APIEndpoint, T: Codable>(
        request: R,
        onSuccess: @escaping ((_: T) -> Void),
        onError: @escaping ((_: Error) -> Void)) {
        
        guard var endpointRequest = self.urlRequest(from: request) else {
            onError(APIError.invalidEndpoint)
            return
        }
        endpointRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(
            with: endpointRequest,
            completionHandler: { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    self.processResponse(data, urlResponse, error, onSuccess: onSuccess, onError: onError)
                }
        }).resume()
    }
    
    // MARK:- Process Request
    
    public static func processResponse<T: Codable>(
        _ dataOrNil: Data?,
        _ urlResponseOrNil: URLResponse?,
        _ errorOrNil: Error?,
        onSuccess: ((_: T) -> Void),
        onError: ((_: Error) -> Void)) {
        
        if let data = dataOrNil {
            do {
                let str = String(decoding: data, as: UTF8.self)
                let decodedResponse = try JSONDecoder().decode(T.self, from: Data(str.utf8))
                onSuccess(decodedResponse)
            } catch {
                onError(APIError.decodingError)
            }
        } else {
            onError(errorOrNil ?? APIError.noData)
        }
    }
}
