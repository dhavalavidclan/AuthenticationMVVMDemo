//
//  Constant.swift

import Foundation
import UIKit

// MARK: AppString constant
struct AppString {
    
    static let rememberMeKey = "rememberMe"
    static let username = "username"
    static let password = "password"
    static let emptyField = "Empty Field"
    
    struct Login {
        static let error = "Error"
        static let emptyUsername = "Please enter email address"
        static let invalidUsername = "Email address is not valid"
        static let emptyPassword = "Please enter password"
        
        static let emptyFirstName = "Please enter first name"
        static let emptyLastName = "Please enter last name"
        static let emptyConfirmPassword = "Please enter confirm password"
        static let mismatchConfirmPassword = "Password and confirm password must be same"
        
    }
    
    struct AlertPopUp {
        static let okAlert = "OK"
        static let yes = "YES"
        static let cancel = "CANCEL"
        static let setting = "SETTING"
        static let delete = "Delete"
    }
    
}

// MARK: Controller Identifier
enum ControllerIdentifier: String {
    case loginVC = "LoginVC"
}

// MARK: Storyboards
enum Storyboards: String {
    case main = "Main"
}

// MARK: CollectionviewCell Reuse String
enum CellReuseString: String {
    case cellWifiSetup1CollectionViewCell = "cellWifiSetup1CollectionViewCell"
    
}
