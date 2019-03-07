//
//  RecentPhotosServiceTests.swift
//  FlickerSampleAppTests
//
//  Created by Baran Kaan Sert on 7.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import XCTest
@testable import FlickerSampleApp

class RecentPhotosServiceTests: XCTestCase {
    
    private var service: RecentPhotosService!

    override func setUp() {
        service = RecentPhotosServiceMock()
    }

    func testPreparedValues() {
        XCTAssertEqual(service.page, 1)
        XCTAssertEqual(service.path, AppConstants.Endpoint.Method.recentPhotos)
        let extras = "url_l,icon_server,owner_name,date_taken"
        XCTAssertEqual(service.queryParameters[AppConstants.Endpoint.QueryNames.extras], extras)
    }
    
    func testFetchingResponseSuccesful() {
        service.fetchRecentPhotos(page: 1, succeed: { (_) in
            XCTAssert(true)
        }) { (_) in
            XCTFail("Should be success with page 1")
        }
    }
    
    func testFetchingResponseFail() {
        service.fetchRecentPhotos(page: 2, succeed: { (_) in
            XCTFail("Should be failed with page 2")
        }) { (error) in
            XCTAssert(true)
        }
    }

}

class RecentPhotosServiceMock: RecentPhotosService {
    override func fetchRecentPhotos(page: Int, succeed: @escaping (PhotosResponse) -> Void, failed: @escaping (Error) -> Void) {
        if page == 1 {
            succeed(PhotosResponse(photos: Photos(page: 1, pages: 10, perpage: 100, photo: [])))
        } else {
            failed(StubError.unknownError)
        }
    }
}

enum StubError: Error, Equatable {
    case unknownError
}
