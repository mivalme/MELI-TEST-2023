//
//  ServiceProtocol.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation
import Alamofire

enum ServiceResponse<T: Codable> {
    case success(response: T)
    case failure(error: String?)
    case notConnectedToInternet
}

protocol ServiceProtocol {
    var configuration: URLSessionConfiguration { get }
    var sessionManager: Session { get }
    
    func request<T: Codable>(_ url: URLConvertible,
                             of type: T.Type,
                             method: HTTPMethod,
                             parameters: [String: Any]?,
                             headers: [String: String]?,
                             completionHandler: @escaping (ServiceResponse<T>) -> Void)
    
    func responseMapping<T: Codable>(from dataRequest: DataRequest,
                                     completionHandler: @escaping (ServiceResponse<T>) -> Void)
}
