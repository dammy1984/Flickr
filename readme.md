## Development
1. After cloning run `pod install` in the root folder to add all the dependencies.
2. Open `Flickr.xcworkspace`.

## Requirements
- iOS 13.0+ 
- Xcode 11+
- Swift 5+

## 3rd Party Libraries
- Alamofire - Alamofire is an HTTP networking library.
- SDWebImage - This library provides an async image downloader with cache support.
- MBProgressHUD - This is an iOS drop-in class that displays a translucent HUD with an indicator and/or labels while work is being done in a background thread.
- SwiftLint - A tool to enforce Swift style and conventions.

## Features
- Implemented to get data from https://www.flickr.com/services/feeds/photos_public.gne.
- Implemented gallery in list view format to show Image, Title and author details.
- Implemented search feature to get public photos feeds based on tags.
- Implemented sorting functionality to sort feeds based on published date.
- Added test case for ViewModel class
- Network layer is implemented in such a way that it becomes easy to mock API's to write test cases.
