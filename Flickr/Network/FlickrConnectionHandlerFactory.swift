//
//  FlickrConnectionHandlerFactory.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation

struct FlickrConnectionHandlerFactory {
    static func getWBInstoreConnectionHandler(type: ConnectionType) -> FlickrEndPoints {
        switch type {
        case .mock:
            return FlickrMockConnectionHandler.shared
        case .live:
            return FlickrLIVEConnectionHandler.shared
        }
    }
}
