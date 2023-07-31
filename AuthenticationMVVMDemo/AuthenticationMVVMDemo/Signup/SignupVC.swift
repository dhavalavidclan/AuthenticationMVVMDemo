//
//  SignupVC.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    private var signupViewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        let (status, message) = signupViewModel.validateSignupData(signupModel: SignupModel.init(firstName: txtFirstName.text, lastName: txtLastName.text, emailAddress: txtEmailAddress.text, password: txtPassword.text, confirmPassword: txtConfirmPassword.text))
        if status == false {
            showAlertError(title: AppString.Login.error, subTitle: message, alertAction: nil)
            return
        }
        print(" Singup Validation success ")
    }
    
    func showAlertError(title: String, subTitle: String? = nil, alertAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppString.AlertPopUp.okAlert.uppercased(), style: .default, handler: alertAction))
        self.present(alert, animated: true)
    }
    
}

// MARK: TextFileds Delegate
extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
