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
    
    private func createUrl(_ req: HTTPRequest) -> String {        
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.Endpoint.Base.scheme
        urlComponents.host = AppConstants.Endpoint.Base.host
        urlComponents.path = AppConstants.Endpoint.Base.path
        var queryParams = req.queryParameters
        queryParams["api_key"] = AppConstants.Endpoint.Query.apiKey
        queryParams["format"] = AppConstants.Endpoint.Query.formatJson
        queryParams["nojsoncallback"] = AppConstants.Endpoint.Query.noJsonCallback
        queryParams["method"] = AppConstants.Endpoint.Method.recentPhotos
        urlComponents.setQueryItems(with: queryParams)
        guard let url = urlComponents.url?.absoluteString else { return "" }
        return url
    }
    
    private func createRequest(_ request: HTTPRequest) -> DataRequest {
        return Alamofire.request(createUrl(request),
                                 method: request.requestType)
            .validate(statusCode: 200..<300)
    }
    
    func call<T: Decodable>(requestObject: HTTPRequest,
                            succeed: @escaping (T)-> Void,
                            failed: @escaping (Error) -> Void) {
        let req: DataRequest = createRequest(requestObject)
        req.responseJSON { print("\($0.result.value ?? "")")}
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
    }
}
