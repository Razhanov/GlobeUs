//
//  MainRequestFactory.swift
//  GlobeUs
//
//  Created by Карим Ражанов on 28.02.2021.
//  Copyright © 2021 Karim Razhanov. All rights reserved.
//

import UIKit
import Alamofire

public enum AuthOtherServices {
    case google, apple, facebook
}

enum ExampleError: Error {
    case invalidRequest(msg: String)
    case unknownError
}

final class MainRequestFactory: AbstractRequestFactory {
    var sessionManager: Session
    var queue: DispatchQueue
    
    enum ExampleError: Error {
        case invalidRequest(msg: String)
        case unknownError
    }
    
    init(sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)) {
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
    //MARK: - getAllClouds
    public func getAllClouds(with name: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "cityName" : name
        ]
        let request = MainRequestRouter.getAllClouds(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let cityResponse = try JSONDecoder().decode(CityResponse.self, from: data)
                        completion(.success(cityResponse))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - getCities
    public func getCities(completion: @escaping (Result<CitiesResponse, Error>) -> Void) {
        let request = MainRequestRouter.getCities
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let citiesResponse = try JSONDecoder().decode(CitiesResponse.self, from: data)
                        completion(.success(citiesResponse))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - login
    public func login(email: String, password: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "email" : email,
            "password": password
        ]
        let request = MainRequestRouter.login(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponce = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponce))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - register
    public func register(email: String, password: String, completion: @escaping (Result<RegisterFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "email" : email,
            "password": password
        ]
        let request = MainRequestRouter.register(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponce = try JSONDecoder().decode(RegisterFullResponse.self, from: data)
                        completion(.success(authResponce))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - signInGoogle
    public func signInGoogle(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInGoogle(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponce = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponce))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - signInApple
    public func signInApple(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInApple(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponce = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponce))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
    
    //MARK: - signInFacebook
    public func signInFacebook(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInFacebook(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponce = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponce))
                    } catch let decodingError as DecodingError {
                        print("decoding error: ", decodingError)
                        completion(.failure(NetworkError.decodingError(error: decodingError)))
                    } catch {
                        completion(.failure(NetworkError.responseError))
                    }
                }
            case 400...499:
                if let error = response.value as? [String: Any] {
                    
                    guard let errors = error["errors"] as? [String: [String]], let msg = errors.first?.value.first, msg == NetworkError.userAlreadyExists.errorMessage else {
                        return completion(.failure(NetworkError.responseError))
                    }
                    completion(.failure(NetworkError.userAlreadyExists))
                }
            case 500...599:
                completion(.failure(NetworkError.serverError))
            default:
                return completion(.failure(NetworkError.internetError))
            }
        }
    }
}
