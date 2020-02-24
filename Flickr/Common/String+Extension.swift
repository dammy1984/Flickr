//
//  String+Extension.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation

extension String {
    /**
        * Convert string to date
        *
        * @param format date format in which the string is
        * @return Date
        */
  func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = format
    guard let date = formatter.date(from: self) else {
      return nil
    }
    
    return date
  }
}
