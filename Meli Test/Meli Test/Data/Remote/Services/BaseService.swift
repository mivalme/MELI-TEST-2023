//
//  BaseService.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation
import Alamofire

class BaseService: ServiceProtocol {
    let configuration: URLSessionConfiguration
    let sessionManager: Session
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default) {
        self.configuration = configuration
        sessionManager = Session(configuration: configuration)
    }
    
    func request<T: Codable>(_ url: URLConvertible,
                             of type: T.Type,
                             method: HTTPMethod = .get,
                             parameters: [String: Any]? = [:],
                             headers: [String: String]? = [:],
                             completionHandler: @escaping (ServiceResponse<T>) -> Void) {
        
        let request = sessionManager.request("\(DataConstants.Environments.dev)\(url)",
                                             method: method,
                                             parameters: parameters,
                                             encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                                             headers: HTTPHeaders(headers ?? [:]))
        
        responseMapping(from: request, completionHandler: completionHandler)
    }
    
    func responseMapping<T: Codable>(from dataRequest: DataRequest,
                                     completionHandler: @escaping (ServiceResponse<T>) -> Void) {
        
        dataRequest
            .validate()
            .responseDecodable(of: T.self) { (serviceResponse) in
                
                guard let response = serviceResponse.value else {
                    
                    if let error = serviceResponse.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.notConnectedToInternet)
                    } else {
                        completionHandler(.failure(error: nil))
                    }
                    return
                }
                
                completionHandler(.success(response: response))
            }
    }
}
