//
//  EatingTests.swift
//  EatingTests
//
//  Created by Dai Pham on 2/25/18.
//  Copyright © 2018 Dai Pham. All rights reserved.
//

import XCTest
import Photos
@testable import Eating

class EatingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let promise = expectation(description: "test")
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status
            {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let allPhotos = PHAsset.fetchAssets(with: fetchOptions)
                allPhotos.enumerateObjects({ (asset, idx, _) in
                    asset.getURL(completionHandler: { (url) in
                        print(url?.absoluteString ?? "unkown")
                        if idx == allPhotos.count - 1 {
                            promise.fulfill()
                        }
                    })
                })
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            }
        }
        
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
