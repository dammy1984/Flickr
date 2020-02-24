//
//  Util.swift
//  Flickr
//
//  Created by Basavaraj KM on 23/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import UIKit

/**
 * Common utility functions
 */
class Util {
    /**
     * Show alert dialog
     *
     * @param title Dialog title
     * @param message Dialog message
     * @return void
     */
    static func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))

        UIWindow.key?.rootViewController?.present(
            alert,
            animated: true,
            completion: nil
        )
    }
}
