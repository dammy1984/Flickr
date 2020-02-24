//
//  FlickrLIVEConnectionHandler.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation
import Alamofire

struct FlickrLIVEConnectionHandler {
    // MARK: - Properties
    private static var sharedLIVEConnectionHandler: FlickrLIVEConnectionHandler = {
        let connectionHandler = FlickrLIVEConnectionHandler()
        // Configuration
        // ...
        return connectionHandler
    }()
    
    // MARK: -
    private let networkRequest: RealNetworkRequest
    
    // Initialization
    private init() {
        networkRequest = RealNetworkRequest.shared
    }
    
    // MARK: - Accessors
    static var shared: FlickrLIVEConnectionHandler {
        return sharedLIVEConnectionHandler
    }
}

extension FlickrLIVEConnectionHandler: FlickrEndPoints {
    func getPublicPhotos(forTags inTags: String, completionHandler:@escaping ((Result<PublicPhotos, Error>) -> Void)) {
        networkRequest.cancelRequests()
        
        var parameters = ["tagmode": "any", "format": "json", "nojsoncallback": 1] as [String: Any]
        if inTags.count > 0 {
            parameters["tags"] = inTags
        }
        
        networkRequest.request(URL(string: EndPoints.photosPublicFeeds.rawValue)!, method: .get, parameters: parameters, headers: nil) { (response) in
            switch response {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let publicPhotos = try decoder.decode(PublicPhotos.self, from:
                        data)
                    completionHandler(.success(publicPhotos))
                } catch let parsingError {
                    completionHandler(.failure(parsingError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
