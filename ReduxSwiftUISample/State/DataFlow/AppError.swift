//
//  AppError.swift
//  ReduxSwiftUISample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String {
        localizedDescription
    }
    
    case passwordWrong
    case registerSuccessful
    case registerFailed
    case registerPasswordVertifyFailed
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        case .registerSuccessful:
            return "注册成功，请重新登录"
        case .registerFailed:
            return "注册失败"
        case .registerPasswordVertifyFailed:
            return "密码不一致"
        case .networkingFailed(let error):
            return error.localizedDescription
        }
    }
}
