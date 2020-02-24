//
//  FlickrPublicPhotosViewModelTests.swift
//  FlickrTests
//
//  Created by Basavaraj KM on 24/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import XCTest

class FlickrPublicPhotosViewModelTests: XCTestCase {

    var viewModel = FlickrPublicPhotosViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FlickrNetworkManager.shared.setConnectionHandler(type: .mock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRetrievePublicPhotos() {
        XCTAssertTrue(self.viewModel.publicPhotosCount == 0)
        XCTAssertNil(self.viewModel.publicPhoto(at: 0))

        viewModel.retrievePublicPhotos(forTags: "Rose") { [unowned self] (error: Error?) in
            XCTAssertNil(error)
            XCTAssertTrue(self.viewModel.publicPhotosCount > 0)
            XCTAssertNotNil(self.viewModel.publicPhoto(at: 0))
            
            self.viewModel.clearData()
            XCTAssertTrue(self.viewModel.publicPhotosCount == 0)
            XCTAssertNil(self.viewModel.publicPhoto(at: 0))
        }
    }
    
}
