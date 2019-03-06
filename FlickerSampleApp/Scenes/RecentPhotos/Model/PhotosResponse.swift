//
//  PhotosResponse.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Foundation

struct PhotosResponse: Decodable {
    let photos: Photos
}

struct Photos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
}

struct Photo: Decodable {
    let title: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let url_l: String?
}



