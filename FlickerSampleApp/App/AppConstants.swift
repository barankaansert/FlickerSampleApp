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
            static let ppUrl = "http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg"
        }
        
        struct QueryNames {
            static let apiKey = "api_key"
            static let method = "method"
            static let format = "format"
            static let nojsoncallback = "nojsoncallback"
            static let extras = "extras"
            static let page = "page"
            static let perPage = "per_page"
        }
        
        struct Query {
            static let apiKey = "c01e839182d04c639b3b8e4660d929e4"
            static let url_l = "url_l"
            static let iconServer = "icon_server"
            static let ownerName = "owner_name"
            static let date = "date_taken"
            static let json = "json"
            static let jsonAccept = "1"
            static let perPageCount = "10"
        }
        
        struct Method {
            static let recentPhotos = "flickr.photos.getRecent"
        }
    }
}
