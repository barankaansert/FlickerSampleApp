//
//  AppConstants.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Foundation

struct AppConstants {
    struct Endpoint {
        struct Base {
            static let scheme = "https"
            static let host = "api.flickr.com"
            static let path = "/services/rest/"
        }
        struct Query {
            static let apiKey = "c01e839182d04c639b3b8e4660d929e4"
            static let formatJson = "json"
            static let noJsonCallback = "1"
            static let extras = "extras"
            static let url_l = "url_l"
        }
        struct Method {
            static let recentPhotos = "flickr.photos.getRecent"
        }
        
    }
}
