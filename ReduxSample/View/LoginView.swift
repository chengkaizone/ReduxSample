//
//  LoginView.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            accountSection
        }
        .alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }

    var accountSection: some View {
        Section(header: Text("用户登录")) {
            if settings.loginUser == nil {
                Picker(selection: settingsBinding.checker.accountBehavior, label: Text("")) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                SecureField("密码", text: settingsBinding.checker.password)
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                }
                if settings.accountRequesting {
                    Text(self.settings.checker.accountBehavior == .register ? "注册中..." : "登录中...")
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        if self.settings.checker.accountBehavior == .login {
                            self.store.dispatch(
                                .login(
                                    username: self.settings.checker.email,
                                    password: self.settings.checker.password
                                )
                            )
                        } else {
                            self.store.dispatch(
                                .register(
                                    username: self.settings.checker.email,
                                    password: self.settings.checker.password
                                )
                            )
                        }
                        
                    }
                }
                
            } else {
                Text(settings.loginUser!.username)
                Button("注销") {
                    self.store.dispatch(.logout)
                }
            }
        }
    }
    
}


extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}

#if DEBUG

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView().environmentObject(Store())
    }
}

#endif
