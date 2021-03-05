//
//  SessionManagerFactory.swift
//  SLS
//
//  Created by Карим Ражанов on 05.03.2020.
//  Copyright © 2020 Vertex. All rights reserved.
//

import UIKit
import Alamofire

class SessionManagerFactory {
    
    static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
    }()
}
