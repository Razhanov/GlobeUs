//
//  AbstractRequestFactory.swift
//  SLS
//
//  Created by Карим Ражанов on 05.03.2020.
//  Copyright © 2020 Vertex. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

protocol AbstractRequestFactory {
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request(_ request: URLRequestConvertible) -> DataRequest
}

extension AbstractRequestFactory {
    @discardableResult
    func request(_ request: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(request)
    }
}
