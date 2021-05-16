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
    case login(parameters: Parameters)
    case register(parameters: Parameters)
    case signInGoogle(parameters: Parameters)
    case signInApple(parameters: Parameters)
    case signInFacebook(parameters: Parameters)

    
    var method: HTTPMethod {
        switch self {
        case .getCities:
            return .get
        case .getAllClouds, .login, .register, .signInGoogle, .signInApple, .signInFacebook:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "city/6"
        case .getAllClouds:
            return "cloud/city"
        case .login:
            return "v1/auth/login"
        case .register:
            return "v1/auth/register"
        case .signInGoogle:
            return "v1/auth/google"
        case .signInApple:
            return "v1/auth/apple"
        case .signInFacebook:
            return "v1/auth/facebook"
        }
    }
    
    var headers: HTTPHeaders {
        
        switch self {
        case .getCities, .getAllClouds, .login, .register, .signInGoogle, .signInApple, .signInFacebook:
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
        case .getAllClouds(let parameters), .login(let parameters), .register(let parameters), .signInGoogle(let parameters), .signInApple(let parameters), .signInFacebook(let parameters):
            urlRequest.headers = headers
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

