//
//  RecentPhotosPresenter.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit

class RecentPhotosPresenter: RecentPhotosPresenterProtocol {
    
    private weak var view: RecentPhotosViewProtocol?
    private let interactor: RecentPhotosInteractorProtocol
    private let router: RecentPhotosWireframeProtocol
    
    init(interface: RecentPhotosViewProtocol, interactor: RecentPhotosInteractorProtocol, router: RecentPhotosWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    /**
     Received photos from web service
     */
    private(set) var photos: [Photo] = []
    
    
    /**
     Page count of loaded images
     */
    var page: Int = 0
    
    /**
     Sending message to interactor for loading photos
     Incrementing page count
     Setting page title
     */
    func load() {
        page += 1
        view?.handleOutput(.updateTitle("Recent Photos"))
        interactor.load(at: page)
    }
    
    
    /**
     Sending message to router to navigate new page
     */
    func selectPhoto() {
        router.navigate(to: .detail)
    }
    
    
    /*
     *
     Profile picture url is dynamically provided, so this method collecting relevant photo information and
     preparing profile picture url and putting to unused attribute of photos struct
     */
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
    
    /**
     Handling interactor's outputs
     - parameter output: interactor output options handle with
     */
    func handleOutput(_ output: RecentPhotosInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view?.handleOutput(.setLoading(isLoading))
        case .showPhotosList(let photos):
            self.photos = photos
            makeProfilePictureUrl()
            view?.handleOutput(.showPhotos)
        }
    }
}
