//
//  SignupModel.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import Foundation

struct SignupModel {
    var firstName: String?
    var lastName: String?
    var emailAddress: String?
    var password: String?
    var confirmPassword: String?
    
    init(firstName: String?, lastName: String?, emailAddress: String?, password: String?, confirmPassword: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
