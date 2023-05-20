//
//  MockRepository.swift
//  Meli TestTests
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import Alamofire
@testable import Meli_Test

final class MockRepository: RemoteRepositoryProtocol {
    var service: ServiceProtocol = MockBaseService()
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func request<T>(url: String,
                    method: Alamofire.HTTPMethod,
                    requestBody: Codable?,
                    completionHandler: @escaping (ServiceResponse<T>) -> Void) where T : Decodable, T : Encodable {
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


