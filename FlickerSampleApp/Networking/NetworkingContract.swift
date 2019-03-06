//
//  NetworkingContract.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Alamofire

protocol HTTPRequest {
    var requestType: HTTPMethod { get set }
    var path: String { get set }
    var queryParameters: [String:String] { get set }
}
