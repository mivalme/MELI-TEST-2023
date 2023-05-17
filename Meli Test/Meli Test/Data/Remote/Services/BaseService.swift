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
            .responseDecodable(of: BaseResponse<T>.self) { (serviceResponse) in
            
            guard let response = serviceResponse.value else {
                
                if let error = serviceResponse.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.notConnectedToInternet)
                } else {
                    let decoder = JSONDecoder()
                    if let data = serviceResponse.data {
                        let baseResponse = try? decoder.decode(BaseResponse<T>.self, from: data)
                        completionHandler(.failure(error: baseResponse?.errors?.first?.message))
                    } else {
                        completionHandler(.failure(error: nil))
                    }
                }
                return
            }
            
            guard let statusCode = serviceResponse.response?.statusCode, statusCode == 200 else {
                completionHandler(.failure(error: response.message == nil ? response.errors?.first?.message : response.message))
                return
            }
            
            if let data = response.data {
                completionHandler(.success(response: data, metadata: response.metadata))
            } else {
                completionHandler(.failure(error: nil))
            }
        }
    }
}
