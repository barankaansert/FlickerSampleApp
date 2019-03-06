//
//  RecentPhotosRequest.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Foundation

protocol RecentPhotosServiceProtocol {
    func fetchRecentPhotos(succeed: @escaping (PhotosResponse) -> Void,
                           failed: @escaping (Error) -> Void)
}

class RecentPhotosService: BaseService<PhotosResponse>, RecentPhotosServiceProtocol {
    
    override init() {
        super.init()
        path = AppConstants.Endpoint.Method.recentPhotos
        queryParameters = [AppConstants.Endpoint.Query.extras: AppConstants.Endpoint.Query.url_l]
    }
    
    func fetchRecentPhotos(succeed: @escaping (PhotosResponse) -> Void,
                           failed: @escaping (Error) -> Void) {
        response(succeed: succeed, failed: failed)
    }
}


