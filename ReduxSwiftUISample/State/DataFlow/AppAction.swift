//
//  AppAction.swift
//  ReduxSwiftUISample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation

enum AppAction {
    
    case register(username: String, password: String, verifyPassword: String)
    case login(username: String, password: String)
    
    case accountBehaviorDone(result: Result<User?, AppError>)
    case logout
    
    case emailValid(valid: Bool)
}
