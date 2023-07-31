//
//  LoginVC.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        let (status, message) = loginViewModel.validateLoginData(loginModel: LoginModel.init(userName: txtEmailAddress.text, password: txtPassword.text))
        if status == false {
            showAlertError(title: AppString.Login.error, subTitle: message, alertAction: nil)
            return
        }
        print(" Login Validation success ")
        
        //let request = LoginRequest(userEmail: "codecat15@gmail.com", userPassword: "1234")
        let request = LoginRequest(title: "ABC Title", body: "XYZ Body", userId: 1)
        loginViewModel.apiCallFromPostManCode(requestData: request) { (loginResponse) in
            print("loginResponse = \(loginResponse.debugDescription)")
        }
        
    }
    
    func showAlertError(title: String, subTitle: String? = nil, alertAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppString.AlertPopUp.okAlert.uppercased(), style: .default, handler: alertAction))
        self.present(alert, animated: true)
    }
    
}

// MARK: TextFileds Delegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

