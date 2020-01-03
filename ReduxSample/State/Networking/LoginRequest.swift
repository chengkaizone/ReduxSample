//
//  LoginRequest.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation
import Combine

struct LoginRequest {
    
    let username: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                if self.password == "password" {
                    let user = User(username: self.username, password: self.password)
                    promise(.success(user))
                } else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
