//
//  AppState.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation
import Combine

struct AppState {
    
    var settings = Settings()
}

extension AppState {
    
    struct Settings {
        
        enum AccountBehavior: CaseIterable {
            case register
            case login
        }
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .removeDuplicates()
                .flatMap { email -> AnyPublisher<Bool, Never> in
                    let validEmail = email.isValidEmailAddress
                    let canSkip = self.accountBehavior == .login
                    switch(validEmail, canSkip) {
                    case (false, _):
                        return Just(false).eraseToAnyPublisher()
                    case (true, false):
                        return EmailCheckingRequest(email: self.email).publisher
                    case (true, true):
                        return Just(true).eraseToAnyPublisher()
                    }
                }
                
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                let publisher = Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map { $0 && ($1 || $2) }
                .eraseToAnyPublisher()
                return publisher
            }
        }
        
        var checker = AccountChecker()
        
        var isEmailValid: Bool = false
        var loginUser: User?
        
        var accountRequesting = false
        
        var registerError: AppError?
        var loginError: AppError?
    }
}
