//
//  MainRequestRouter.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation
import Alamofire

enum MainRequestRouter: AbstractRequestRouter {
    case getCities(countryId: Int)
    case getAllClouds(parameters: Parameters)
    case login(parameters: Parameters)
    case register(parameters: Parameters)
    case signInWithGoogle(parameters: Parameters)
    case signInWithApple(parameters: Parameters)
    case signInWithFacebook(parameters: Parameters)
    case getCountries(langId: Int)
    case getProfile
    case updateProfile(parameters: Parameters)

    
    var method: HTTPMethod {
        switch self {
        case .getCities, .getCountries, .getProfile:
            return .get
        case .getAllClouds, .login, .register, .signInWithGoogle, .signInWithApple, .signInWithFacebook:
            return .post
        case .updateProfile:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .getCities(let countryId):
            return "city/\(countryId)"
        case .getAllClouds:
            return "cloud/city"
        case .login:
            return "v1/auth/login"
        case .register:
            return "v1/auth/register"
        case .signInWithGoogle:
            return "v1/auth/google"
        case .signInWithApple:
            return "v1/auth/apple"
        case .signInWithFacebook:
            return "v1/auth/facebook"
        case .getCountries(let langId):
            return "country/\(langId)"
        case .getProfile, .updateProfile:
            return "v1/user"
        }
    }
    
    var headers: HTTPHeaders {
        
        switch self {
        case .getCities, .getAllClouds, .login, .register, .signInWithGoogle, .signInWithApple, .signInWithFacebook, .getCountries:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        case .getProfile, .updateProfile:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": AuthService.accessToken ?? ""
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
        case .getCities, .getCountries, .getProfile:
            urlRequest.headers = headers
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getAllClouds(let parameters), .login(let parameters), .register(let parameters), .signInWithGoogle(let parameters), .signInWithApple(let parameters), .signInWithFacebook(let parameters), .updateProfile(let parameters):
            urlRequest.headers = headers
            urlRequest = try CustomPatchEncding().encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

