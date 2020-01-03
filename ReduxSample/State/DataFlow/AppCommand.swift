//
//  AppCommand.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    
    let username: String
    let password: String
    
    func execute(in store: Store) {
        _ = LoginRequest(username: username, password: password).publisher
            .sink(receiveCompletion: { complete in
                switch complete {
                case .failure(let error):
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                default:
                    break
                }
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
    }
}

struct RegisterAppCommand: AppCommand {
    
    let username: String
    let password: String
    
    func execute(in store: Store) {
        _ = RegisterRequest(username: username, password: password).publisher
            .sink(receiveCompletion: { complete in
                switch complete {
                case .failure(let error):
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                default:
                    break
                }
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(nil)))
            })
    }
}
