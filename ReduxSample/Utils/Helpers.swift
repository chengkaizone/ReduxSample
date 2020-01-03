//
//  Helpers.swift
//  ReduxSample
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 tony. All rights reserved.
//

import Foundation

extension String {

    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
