//
//  SignupViewModel.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import Foundation

class SignupViewModel: NSObject {
    
    func validateSignupData(signupModel: SignupModel) -> (Bool, String) {
        guard let trimmedFirstName = signupModel.firstName?.trimLeadingOrTrailingSpace(), !trimmedFirstName.isEmpty else {
            return (false, AppString.Login.emptyFirstName)
        }
        
        guard let trimmedLastName = signupModel.lastName?.trimLeadingOrTrailingSpace(), !trimmedLastName.isEmpty else {
            return (false, AppString.Login.emptyLastName)
        }
        
        guard let trimmedEmail = signupModel.emailAddress?.trimLeadingOrTrailingSpace(), !trimmedEmail.isEmpty else {
            return (false, AppString.Login.emptyUsername)
        }
        
        if !DataValidator.checkEmailValid(trimmedEmail) {
            return (false, AppString.Login.invalidUsername)
        }
        
        guard let trimmedPassword = signupModel.password?.trimLeadingOrTrailingSpace(), !trimmedPassword.isEmpty else {
            return (false, AppString.Login.emptyPassword)
        }
        
        guard let trimmedConfirmPassword = signupModel.confirmPassword?.trimLeadingOrTrailingSpace(), !trimmedConfirmPassword.isEmpty else {
            return (false, AppString.Login.emptyConfirmPassword)
        }
        
        if trimmedPassword != trimmedConfirmPassword {
            return (false, AppString.Login.mismatchConfirmPassword)
        }
        
        return (true, "")
    }

}
