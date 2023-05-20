//
//  MockBaseService.swift
//  Meli TestTests
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import XCTest
import Foundation
import Alamofire
@testable import Meli_Test

enum MockResponse {
    case success(jsonFile: String)
    case failure(message: String)
    case notConnectedToInternet
}

struct MockService: Hashable {
    let endpoint: String
    var method: Alamofire.HTTPMethod = .get
}

final class MockBaseService: ServiceProtocol {
    var configuration: URLSessionConfiguration
    var sessionManager: Alamofire.Session
    
    var mockResponse: [MockService: MockResponse] = [:]
    
    init() {
        self.configuration = URLSessionConfiguration.af.default
        sessionManager = Session()
    }
    
    func request<T>(_ url: Alamofire.URLConvertible,
                    of type: T.Type,
                    method: Alamofire.HTTPMethod,
                    parameters: [String : Any]?,
                    headers: [String : String]?,
                    completionHandler: @escaping (ServiceResponse<T>) -> Void) where T : Decodable, T : Encodable {
        
        commonBaseResponseHandling(url,
                                    of: type,
                                    method: method,
                                    parameters: parameters,
                                    headers: headers,
                                    completionHandler: completionHandler)
    }
    
    func responseMapping<T>(from dataRequest: Alamofire.DataRequest,
                            completionHandler: @escaping (ServiceResponse<T>) -> Void) where T : Decodable, T : Encodable {
        
    }

    private func commonBaseResponseHandling<T>(_ url: Alamofire.URLConvertible,
                                             of type: T.Type,
                                             method: Alamofire.HTTPMethod,
                                             parameters: [String : Any]?,
                                             headers: [String : String]?,
                                             completionHandler: @escaping (ServiceResponse<T>) -> Void) {
        var queryParams = ""
        if method == .get, let parameters = parameters, !parameters.isEmpty {
            queryParams = "?"
            parameters.sorted(by: { $0.key < $1.key }).enumerated().forEach({ queryParams += "\($0.element.key)=\($0.element.value)\($0.offset == (parameters.count - 1) ? "" : "&")" })
        }
        
        guard let url = try? url.asURL().absoluteString + queryParams,
              let mockResponse = mockResponse.first(where: { $0.key.endpoint == url && $0.key.method == method }) else {
            return
        }
        
        switch mockResponse.value {
        case .success(let jsonFile):
            guard let jsonPath = Bundle(identifier: "com.mivalme.Meli-TestTests")?.path(forResource: jsonFile, ofType: "json"),
                    let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
                return XCTFail("No JSON file found or can not get data")
            }
            
            if let decodedData = try? JSONDecoder().decode(T.self, from: jsonData){
                completionHandler(.success(response: decodedData))
            } else {
                return XCTFail("Can not decode data from json file to codable object")
            }
        case .failure(let message):
            completionHandler(.failure(error: message))
        case .notConnectedToInternet:
            completionHandler(.notConnectedToInternet)
        }
    }
}
