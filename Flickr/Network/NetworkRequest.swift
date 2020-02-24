//
//  NetworkRequest.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    func cancelRequests()
    func request(
        _ url: URL,
        method: RequestMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (Swift.Result<Data, Error>) -> Void)
}
