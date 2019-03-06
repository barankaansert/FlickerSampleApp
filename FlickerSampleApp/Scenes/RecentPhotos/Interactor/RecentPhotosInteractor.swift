//
//  RecentPhotosInteractor.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit

class RecentPhotosInteractor: RecentPhotosInteractorProtocol {
    
    private let service: RecentPhotosServiceProtocol
    private var photos: [Photo] = []
    
    init(service: RecentPhotosServiceProtocol) {
        self.service = service
    }
    
    var delegate: RecentPhotosInteractorDelegate?
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchRecentPhotos(succeed: { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            self.photos = response.photos.photo
            self.delegate?.handleOutput(.showPhotosList(self.photos))
        }) { (error) in
            self.delegate?.handleOutput(.setLoading(false))
            print(error)
        }
    }
    
    func selectPhoto(at index: Int) {
        delegate?.handleOutput(.showPhotoDetail(self.photos[index]))
    }
}
