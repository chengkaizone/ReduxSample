//
//  AppError.swift
//  ReduxSample
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
    case registerFailed
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        case .registerFailed:
            return "注册失败"
        case .networkingFailed(let error):
            return error.localizedDescription
        }
    }
}
