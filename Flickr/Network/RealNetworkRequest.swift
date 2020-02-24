//
//  RealNetworkRequest.swift
//  Flickr
//
//  Created by Basavaraj KM on 22/02/20.
//  Copyright © 2020 Basavaraj KM. All rights reserved.
//

import Foundation
import Alamofire

class RealNetworkRequest: NetworkRequest {
    // MARK: - Properties
    private static var sharedNetworkRequest: RealNetworkRequest = {
        let networkRequest = RealNetworkRequest()
        
        // Configuration
        // ...
        
        return networkRequest
    }()
    
    // MARK: -
    
    private let session: Session
    
    // Initialization
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - Accessors
    
    static var shared: RealNetworkRequest {
        return sharedNetworkRequest
    }
    
    func cancelRequests() {
        session.cancelAllRequests()
    }

    func request(_ url: URL, method: RequestMethod, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        let requestMethod = httpMethod(fromString: method.rawValue)
        session.request(url, method: requestMethod, parameters: parameters, encoding: parameterEncoding(forMethod: requestMethod), headers: HTTPHeaders(headers ?? [:])).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseData = response.data
                    else {
                        completion(.failure(FlickrError.noData))
                        return
                }
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension RealNetworkRequest {
    func httpMethod(fromString method: String) -> HTTPMethod {
        return HTTPMethod(rawValue: method)
    }
    
    func parameterEncoding(forMethod method: HTTPMethod) -> ParameterEncoding {
        var parameterEncoding: ParameterEncoding = URLEncoding.queryString
        if method == .post || method == .put {
            parameterEncoding = JSONEncoding.default
        }
        
        return parameterEncoding
    }
}
