//
//  LoginModel.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import Foundation

struct LoginModel {
    var userName: String?
    var password: String?
    
    init(userName: String?, password: String?) {
        self.userName = userName
        self.password = password
    }
}
