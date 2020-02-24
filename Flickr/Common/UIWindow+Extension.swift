//
//  UIWindow+Extension.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
