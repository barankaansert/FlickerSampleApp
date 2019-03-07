//
//  RecentPhotosPresenterTests.swift
//  FlickerSampleAppTests
//
//  Created by Baran Kaan Sert on 7.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import XCTest
@testable import FlickerSampleApp

class RecentPhotosPresenterTests: XCTestCase {
    
    private var presenter: RecentPhotosPresenter!
    private var view: ViewMock!
    private var router: MockRouter!

    override func setUp() {
        view = ViewMock()
        let service = MockRecentPhotosService()
        let interactor = RecentPhotosInteractor(service: service)
        router = MockRouter()
        router.viewController = view
        presenter = RecentPhotosPresenter(interface: view, interactor: interactor, router: router)
        view.presenter = self.presenter
    }

    func testInitialValues() {
        XCTAssertEqual(presenter.photos.count, 0)
        XCTAssertEqual(presenter.page, 0)
    }
    
    func testLoad() {
        presenter.load()
        XCTAssertEqual(presenter.photos.count, 1)
    }
    
    func testMakingProfilePictureUrl() {
        presenter.load()
        let ppUrl = "http://farm8.staticflickr.com/mock_server/buddyicons/owner@01.jpg"
        XCTAssertEqual(presenter.photos.first?.profilePictureUrl, ppUrl)
    }
    
    func testOutputs() {
        presenter.load()
        XCTAssertEqual(view.outputs.count, 4)
        XCTAssertEqual(view.outputs[0], RecentPhotosPresenterOutput.updateTitle("Recent Photos"))
        XCTAssertEqual(view.outputs[1], RecentPhotosPresenterOutput.setLoading(true))
        XCTAssertEqual(view.outputs[2], RecentPhotosPresenterOutput.setLoading(false))
        XCTAssertEqual(view.outputs[3], RecentPhotosPresenterOutput.showPhotos)
    }
    
    func testRouteOutputs() {
        presenter.selectPhoto()
        XCTAssertEqual(router.routes.count, 1)
        XCTAssertEqual(router.routes[0], RecentPhotosRoute.detail)
    }
}


class ViewMock: UIViewController, RecentPhotosViewProtocol {
    var presenter: RecentPhotosPresenter!
    var outputs: [RecentPhotosPresenterOutput] = []
    
    func handleOutput(_ output: RecentPhotosPresenterOutput) {
        outputs.append(output)
    }
}

class MockRecentPhotosService: RecentPhotosService {
    override func fetchRecentPhotos(page: Int, succeed: @escaping (PhotosResponse) -> Void, failed: @escaping (Error) -> Void) {
        let photos = [Photo(title: "title", owner: "owner@01", ownerName: "baran", secret: "secret", iconserver: "mock_server", iconfarm: 8, photoUrl: "", date: "", profilePictureUrl: nil)]
        let response = PhotosResponse(photos: Photos(page: 1, pages: 10, perpage: 100, photo: photos))
        succeed(response)
    }
}

class MockRouter: RecentPhotosRouter {
    var routes: [RecentPhotosRoute] = []
    
    override func navigate(to route: RecentPhotosRoute) {
        routes.append(route)
    }
}
