//
//  RemoteRepository.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation
import Alamofire

protocol RemoteRepositoryProtocol {
    var service: ServiceProtocol { get }
    
    func request<T: Codable>(url: String, method: HTTPMethod, requestBody: Codable?, completionHandler: @escaping (ServiceResponse<T>) -> Void)
}

class RemoteRepository: RemoteRepositoryProtocol {
    
    let service: ServiceProtocol
    
    public init(service: ServiceProtocol = BaseService()) {
        self.service = service
    }
    
    func request<T: Codable>(url: String, method: HTTPMethod, requestBody: Codable? = nil, completionHandler: @escaping (ServiceResponse<T>) -> Void) {
        
        var parameters: [String: Any]?
        
        if let request = requestBody {
            parameters = request.dictionary
        }
        
        service.request(url,
                        of: T.self,
                        method: method,
                        parameters: parameters,
                        headers: nil) { response in
            
            switch response {
            case .success(let response):
                completionHandler(.success(response: response))
            case .failure(let error):
                completionHandler(.failure(error: error))
            case .notConnectedToInternet:
                completionHandler(.notConnectedToInternet)
            }
        }
    }
}
