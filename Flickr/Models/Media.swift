//
//  Media.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation
struct Media: Codable {
	let link: String
    
    enum CodingKeys: String, CodingKey {
        case link = "m"
    }
}
