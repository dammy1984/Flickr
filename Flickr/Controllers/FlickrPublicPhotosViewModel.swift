//
//  FlickrPublicPhotosViewModel.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import UIKit

class FlickrPublicPhotosViewModel {

    var publicPhotos: [PhotoViewModel] = []

    var publicPhotosCount: Int {
        return publicPhotos.count
    }

    func clearData() {
        publicPhotos.removeAll()
    }
    
    func retrievePublicPhotos(forTags inTags: String, completionHandler: @escaping ((Error?) -> Void)) {
        FlickrNetworkManager.shared.getPublicPhotos(forTags: inTags) { [weak self] (result: PublicPhotos?, error: Error?) in
            if let weakSelf = self, let publicPhotosObj = result {
                weakSelf.publicPhotos = publicPhotosObj.items.map {
                    PhotoViewModel(title: $0.title, link: $0.media.link, dateTaken: $0.dateTaken.toDate(), published: $0.published.toDate(), author: $0.author)
                }
                weakSelf.sortData(isAscending: true)
            }
            completionHandler(error)
        }
    }

    func publicPhoto(at index: Int) -> PhotoViewModel? {
        if index < publicPhotosCount {
            return publicPhotos[index]
        }
        return nil
    }

    func sortData(isAscending: Bool) {
        var comparisonResult: ComparisonResult = .orderedDescending
        if isAscending == true {
            comparisonResult = .orderedAscending
        }
        
        publicPhotos = publicPhotos.sorted(by: {
            $0.published!.compare($1.published!) == comparisonResult
        })
    }
}
