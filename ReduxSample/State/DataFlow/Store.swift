//
//  Store.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Combine

class Store: ObservableObject {
    
    @Published var appState = AppState()
    
    private let bag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid.sink {
            isValid in
            self.dispatch(.emailValid(valid: isValid))
        }.add(to: bag)
    }
    
    func dispatch(_ action: AppAction) {
        
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        
        var appState = state
        var command: AppCommand?
        switch action {
        case .register(let username, let password):
            if appState.settings.accountRequesting {
                break
            }
            appState.settings.accountRequesting = true
            command = RegisterAppCommand(username: username, password: password)
        case .login(let username, let password):
            if appState.settings.accountRequesting {
                break
            }
            appState.settings.accountRequesting = true
            command = LoginAppCommand(username: username, password: password)
        case .accountBehaviorDone(let result):
            appState.settings.accountRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        case .logout:
            appState.settings.loginUser = nil
        case .emailValid(let valid):
            appState.settings.isEmailValid = valid
        }
        return (appState, command)
    }
    
}

fileprivate class DisposeBag {
    
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

fileprivate extension AnyCancellable {
    
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
