//
//  NetworkError.swift
//  Recoverable
//
//  Created by Aleksandr Lavrinenko on 13.01.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import Foundation

enum NetworkError {
    // Любой 500 код
    case serverError
    // Ответ не такой, как мы ожидаем
    case responseError
    // Ответа нет, отвалились по таймауту, отсуствует сеть
    case internetError
    // User already exists
    case userAlreadyExists
    
    case decodingError(error: DecodingError)
    
    // Ошибка от сервера, когда пользователю не хватает места в хранилище
    case runOfSpace
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError, .responseError:
            return "ой, что-то пошло не так"
        case .internetError:
            return "Нет соединения с интернетом"
        case .userAlreadyExists:
            return "Пользователь с этим адресом уже существует"
        case .runOfSpace:
            return "Закончилоь место"
        case .decodingError(let error):
            return "\(error.localizedDescription)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .serverError:
            return "Сервер недоступен"
        case .responseError:
            return "Проверьте правильность вводимых данных"
        case .internetError:
            return "Пожалуйста, проверьте ваше интернет-соединение"
        case .userAlreadyExists:
            return "Аккаунт зарегистрирован воспользуйтесь востоновлением пароля"
        case .runOfSpace:
            return "Пожалуйста освободите место в памяти телефона"
        case .decodingError:
            return ""
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .serverError:
            return ""
        case .responseError:
            return ""
        case .internetError:
            return ""
        case .userAlreadyExists:
            return "User already exists"
        case .runOfSpace:
            return ""
        case .decodingError(let error):
            return "\(error.errorDescription)"
        }
    }
}
