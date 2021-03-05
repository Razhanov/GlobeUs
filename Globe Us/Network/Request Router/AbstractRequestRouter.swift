//
//  AbstractRequestRouter.swift
//  SLS
//
//  Created by Карим Ражанов on 05.03.2020.
//  Copyright © 2020 Vertex. All rights reserved.
//

import UIKit
import Alamofire

protocol AbstractRequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var fullUrl: URL { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
}

extension AbstractRequestRouter {
    
    var baseUrl: URL {
         let string = "https://selfident.ompr.io/api/"
        return URL.init(string: string)!
    }
    
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
}
