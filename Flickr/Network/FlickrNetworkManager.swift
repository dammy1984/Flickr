//
//  FlickrNetworkManager.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation

struct FlickrNetworkManager {
    static var shared = FlickrNetworkManager()
    
    private var connectionHandler = FlickrConnectionHandlerFactory.getWBInstoreConnectionHandler(type: .live)
    
    private init() {
        //TO-DO
    }
    
    mutating func setConnectionHandler(type: ConnectionType) {
        connectionHandler = FlickrConnectionHandlerFactory.getWBInstoreConnectionHandler(type: type)
    }
    
    func getPublicPhotos(forTags inTags: String, completionHandler: @escaping ((PublicPhotos?, Error?) -> Void)) {
        connectionHandler.getPublicPhotos(forTags: inTags) { response in
            switch response {
            case .success(let response):
                completionHandler(response, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
