//
//  FlickrEndPoints.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation

protocol FlickrEndPoints {
    func getPublicPhotos(forTags inTags: String, completionHandler:@escaping ((Result<PublicPhotos, Error>) -> Void))
}
