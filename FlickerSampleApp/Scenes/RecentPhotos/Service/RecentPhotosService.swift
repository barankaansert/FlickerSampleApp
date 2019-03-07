//
//  RecentPhotosRequest.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Foundation

protocol RecentPhotosServiceProtocol {
    func fetchRecentPhotos(page: Int,
                           succeed: @escaping (PhotosResponse) -> Void,
                           failed: @escaping (Error) -> Void)
}

class RecentPhotosService: BaseService<PhotosResponse>, RecentPhotosServiceProtocol {
    
    /**
     Page count of service query. Default value is 1
     */
    var page: Int = 1 {
        didSet {
            queryParameters[AppConstants.Endpoint.QueryNames.page] = "\(page)"
        }
    }
    
    /**
     Setting Request path and queries
     */
    override init() {
        super.init()
        let extrasList: [String] = [AppConstants.Endpoint.Query.url_l,
                                    AppConstants.Endpoint.Query.iconServer,
                                    AppConstants.Endpoint.Query.ownerName,
                                    AppConstants.Endpoint.Query.date]
        
        let extras = extrasList.joined(separator: ",")
        
        path = AppConstants.Endpoint.Method.recentPhotos
        queryParameters = [AppConstants.Endpoint.QueryNames.extras: extras,
                           AppConstants.Endpoint.QueryNames.perPage: AppConstants.Endpoint.Query.perPageCount,
                           AppConstants.Endpoint.QueryNames.page: "\(page)"]
    }
    
    /**
     Comminucation with network manager
     */
    func fetchRecentPhotos(page: Int,
                           succeed: @escaping (PhotosResponse) -> Void,
                           failed: @escaping (Error) -> Void) {
        self.page = page
        response(succeed: succeed, failed: failed)
    }
}


