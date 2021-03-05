//
//  RequestFactory.swift
//  SLS
//
//  Created by Карим Ражанов on 05.03.2020.
//  Copyright © 2020 Vertex. All rights reserved.
//

import UIKit
import Alamofire

class RequestFactory {

    private var mainFactory: MainRequestFactory?
    
    lazy private var sessionManager: Session = {
        return SessionManagerFactory.sessionManager
    }()
    
    func makeMainFactory() -> MainRequestFactory {
        if let factory = mainFactory {
            return factory
        } else {
            let factory = MainRequestFactory(sessionManager: sessionManager)
            mainFactory = factory
            return factory
        }
    }
}
