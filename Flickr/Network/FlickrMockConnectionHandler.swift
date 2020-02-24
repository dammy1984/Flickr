//
//  FlickrMockConnectionHandler.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation
import Alamofire

struct FlickrMockConnectionHandler {
    // MARK: - Properties
    private static var sharedMockConnectionHandler: FlickrMockConnectionHandler = {
        let connectionHandler = FlickrMockConnectionHandler()
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
    static var shared: FlickrMockConnectionHandler {
        return sharedMockConnectionHandler
    }
}

extension FlickrMockConnectionHandler: FlickrEndPoints {
    func getPublicPhotos(forTags inTags: String, completionHandler:@escaping ((Result<PublicPhotos, Error>) -> Void)) {
        let bundle = Bundle.main
        guard let path = bundle.url(forResource: "PublicPhotosMock", withExtension: "json") else {
            //File Not Found
            return
        }
        
        do {
            let contents = try Data(contentsOf: path)
            
            do {
                let decoder = JSONDecoder()
                let publicPhotos = try decoder.decode(PublicPhotos.self, from:
                    contents)
                completionHandler(.success(publicPhotos))
            } catch let parsingError {
                completionHandler(.failure(parsingError))
            }
        } catch {
            print("contents could not be loaded")
        }
    }
}
