//
//  NetworkManager.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import Alamofire

let Networker = NetworkManager()

final class NetworkManager {
    
    /**
     Preventing initialize another instances
     */
    fileprivate init() { }
    
    /**
     Creating and manipulating request url
     - parameter req: require to manipulate HTTPRequest path & queryParameters
     */
    private func createUrl(_ req: HTTPRequest) -> String {        
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.Endpoint.Base.scheme
        urlComponents.host = AppConstants.Endpoint.Base.host
        urlComponents.path = AppConstants.Endpoint.Base.path
        var queryParams = req.queryParameters
        queryParams[AppConstants.Endpoint.QueryNames.apiKey] = AppConstants.Endpoint.Query.apiKey
        queryParams[AppConstants.Endpoint.QueryNames.method] = AppConstants.Endpoint.Method.recentPhotos
        queryParams[AppConstants.Endpoint.QueryNames.format] = AppConstants.Endpoint.Query.json
        queryParams[AppConstants.Endpoint.QueryNames.nojsoncallback] = AppConstants.Endpoint.Query.jsonAccept
        urlComponents.setQueryItems(with: queryParams)
        guard let url = urlComponents.url?.absoluteString else { return "" }
        return url
    }
    
    /**
     Creating DataRequest
     - parameter req: require to create and send data request
     */
    private func createRequest(_ request: HTTPRequest) -> DataRequest {
        return Alamofire.request(createUrl(request),
                                 method: request.requestType)
            .validate()
    }
    
    /**
     Dispatching network requests with web services
     - parameter requestObject: require to create and send data request
     - parameter succeed: succeed completion block of network request. Returning generic type of response class
     - parameter failed: failed completion block of network request. Returnin Error type
     */
    @discardableResult
    func call<T: Decodable>(requestObject: HTTPRequest,
                            succeed: @escaping (T)-> Void,
                            failed: @escaping (Error) -> Void) -> DataRequest {
        let req: DataRequest = createRequest(requestObject)
        req.responseData { (data) in
            switch data.result {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: value)
                    succeed(responseObject)
                } catch let error {
                    failed(error)
                }
            case .failure(let error):
                failed(error)
            }
        }
        return req
    }
}
