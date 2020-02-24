//
//  FlickrConstants.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation
/**
* Common constants
*/
enum EndPoints: String {
    case photosPublicFeeds = "https://www.flickr.com/services/feeds/photos_public.gne"
}

enum ConnectionType: Int {
    case mock = 0
    case live = 1
}

enum RequestMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put    = "PUT"
}

// MARK: FLICKR ERROR
enum FlickrError: Error {
    case noData
}

extension FlickrError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No Data"
        }
    }
}
