//
//  RegisterRequest.swift
//  ReduxSwiftUISample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation
import Combine

struct RegisterRequest {
    
    let username: String
    let password: String
    
    var publisher: AnyPublisher<User?, AppError> {
        
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                if self.username == "example@email.com" {
                    promise(.success(nil))
                } else {
                    promise(.failure(.registerFailed))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
