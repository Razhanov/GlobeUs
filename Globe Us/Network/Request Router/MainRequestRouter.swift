//
//  MainRequestRouter.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation
import Alamofire

enum MainRequestRouter: AbstractRequestRouter {
    case getCities
    case getAllClouds(parameters: Parameters)

    
    var method: HTTPMethod {
        switch self {
        case .getCities:
            return .get
        case .getAllClouds:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "city/6"
        case .getAllClouds:
            return "cloud/city"
        }
    }
    
    var headers: HTTPHeaders {
        
        switch self {
        case .getCities, .getAllClouds:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
    
    struct CustomPatchEncding: ParameterEncoding {
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            let mutableRequest = try? URLEncoding().encode(urlRequest, with: parameters) as? NSMutableURLRequest
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
                mutableRequest?.httpBody = jsonData
                
            } catch {
                debugPrint(error.localizedDescription)
            }
            return mutableRequest! as URLRequest
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getCities:
            urlRequest.headers = headers
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getAllClouds(let parameters):
            urlRequest.headers = headers
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

