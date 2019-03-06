//
//  RecentPhotosProtocols.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import Foundation

//MARK: Wireframe -
enum RecentPhotosRoute {
    case detail(Photo)
}

protocol RecentPhotosWireframeProtocol: class {
    func navigate(to route: RecentPhotosRoute)
}
//MARK: Presenter -
protocol RecentPhotosPresenterProtocol: class {
    var photos: [Photo] { get }
    func load()
    func selectPhoto(at index: Int)
}

//MARK: Interactor -
protocol RecentPhotosInteractorProtocol: class {
    var delegate: RecentPhotosInteractorDelegate? { get set }
    func load()
    func selectPhoto(at index: Int)
}

enum RecentPhotosInteractorOutput {
    case setLoading(Bool)
    case showPhotosList([Photo])
    case showPhotoDetail(Photo)
}

protocol RecentPhotosInteractorDelegate {
    func handleOutput(_ output: RecentPhotosInteractorOutput)
}

//MARK: View -

enum RecentPhotosPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showPhotos()
}

protocol RecentPhotosViewProtocol: class {
    func handleOutput(_ output: RecentPhotosPresenterOutput)
}

