//
//  BaseService.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Alamofire

class BaseService<ItemType: Decodable>: HTTPRequest {
    
    typealias SuccessType = ((ItemType) -> Void)
    typealias FailureType = ((Error) -> Void)
    
    var requestType: HTTPMethod = .get
    var path: String = ""
    var queryParameters: [String : String] = [:]
    
    // MARK: Get Response
    func response(succeed: @escaping SuccessType, failed: @escaping FailureType) {
        Networker.call(requestObject: self, succeed: succeed, failed: failed)
    }
    
}
