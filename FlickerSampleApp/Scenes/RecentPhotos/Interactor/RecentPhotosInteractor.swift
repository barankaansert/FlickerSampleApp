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
    
    weak var delegate: RecentPhotosInteractorDelegate?
    
    /**
     Getting images from web services.
     - parameter page: page count of recent photos.
     */
    func load(at page: Int) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchRecentPhotos(page: page, succeed: { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            self.photos.append(contentsOf: response.photos.photo)
            self.delegate?.handleOutput(.showPhotosList(self.photos))
        }) { (error) in
            self.delegate?.handleOutput(.setLoading(false))
        }
    }
}
