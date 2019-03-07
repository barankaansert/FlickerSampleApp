//
//  NetworkManagerTests.swift
//  FlickerSampleAppTests
//
//  Created by Baran Kaan Sert on 7.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import XCTest
import Alamofire
@testable import FlickerSampleApp

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testUrlComponents() {
        let service = RecentPhotoServiceStub()
        service.fetchRecentPhotos(page: 0, succeed: { (_) in }) { (_) in }
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Base.path))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Base.scheme))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Base.host))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.QueryNames.format))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.QueryNames.method))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.QueryNames.apiKey))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.QueryNames.nojsoncallback))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Query.apiKey))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Method.recentPhotos))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Query.json))
        XCTAssertTrue(service.req!.request!.url!.absoluteString.contains(AppConstants.Endpoint.Query.jsonAccept))
    }

}

class RecentPhotoServiceStub: RecentPhotosService {
    var req: DataRequest?
    override func fetchRecentPhotos(page: Int, succeed: @escaping (PhotosResponse) -> Void, failed: @escaping (Error) -> Void) {
        req = Networker.call(requestObject: self, succeed: succeed, failed: failed)
    }
}
