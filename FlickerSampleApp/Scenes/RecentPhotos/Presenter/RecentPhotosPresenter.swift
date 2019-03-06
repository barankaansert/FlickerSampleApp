//
//  RecentPhotosPresenter.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit

class RecentPhotosPresenter: RecentPhotosPresenterProtocol {
    private unowned var view: RecentPhotosViewProtocol
    private let interactor: RecentPhotosInteractorProtocol
    private let router: RecentPhotosWireframeProtocol
    private(set) var photos: [Photo] = []

    init(interface: RecentPhotosViewProtocol, interactor: RecentPhotosInteractorProtocol, router: RecentPhotosWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }

    
    func load() {
        view.handleOutput(.updateTitle("Recent Photos"))
        interactor.load()
    }
    
    func selectPhoto(at index: Int) {
        interactor.selectPhoto(at: index)
    }
    
    private func makeProfilePictureUrl() {
        var photoList: [Photo] = []
        for i in 0..<photos.count {
            var photo = photos[i]
            var url: String = AppConstants.Endpoint.Base.ppUrl
            url = url.replacingOccurrences(of: "{icon-farm}", with: "\(photo.iconfarm)")
            url = url.replacingOccurrences(of: "{icon-server}", with: photo.iconserver)
            url = url.replacingOccurrences(of: "{nsid}", with: photo.owner)
            photo.profilePictureUrl = url
            photoList.append(photo)
        }
        self.photos = photoList
    }
}

extension RecentPhotosPresenter: RecentPhotosInteractorDelegate {
    func handleOutput(_ output: RecentPhotosInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showPhotosList(let photos):
            self.photos = photos
            makeProfilePictureUrl()
            view.handleOutput(.showPhotos())
        case .showPhotoDetail(let photo):
            router.navigate(to: .detail(photo))
        }
    }
}
