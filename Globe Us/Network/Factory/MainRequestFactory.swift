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
    public func getCities(countryId: Int, completion: @escaping (Result<CitiesResponse, Error>) -> Void) {
        let request = MainRequestRouter.getCities(countryId: countryId)
        
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
                        let authResponse = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponse))
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
                        let authResponse = try JSONDecoder().decode(RegisterFullResponse.self, from: data)
                        completion(.success(authResponse))
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
    
    //MARK: - signInWithGoogle
    public func signInWithGoogle(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInWithGoogle(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponse = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponse))
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
    
    //MARK: - signInWithApple
    public func signInWithApple(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInWithApple(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponse = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponse))
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
    
    //MARK: - signInWithFacebook
    public func signInWithFacebook(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "userId" : userId
        ]
        
        let request = MainRequestRouter.signInWithFacebook(parameters: parameters)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let authResponse = try JSONDecoder().decode(AuthFullResponse.self, from: data)
                        completion(.success(authResponse))
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
    
    //MARK: - getCountries
    public func getCountries(langId: Int, completion: @escaping (Result<CountriesResponse, Error>) -> Void) {
        let request = MainRequestRouter.getCountries(langId: langId)
        
        self.request(request).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch statusCode {
            case 200 ... 399:
                if let data = response.data {
                    do {
                        let countriesResponse = try JSONDecoder().decode(CountriesResponse.self, from: data)
                        completion(.success(countriesResponse))
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
