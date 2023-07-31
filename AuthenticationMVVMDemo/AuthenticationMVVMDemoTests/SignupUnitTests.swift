//
//  SignupUnitTests.swift
//  AuthenticationMVVMDemoTests
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import XCTest

class SignupUnitTests: XCTestCase {
    
    private var signupViewModel: SignupViewModel?
    private var signupModel: SignupModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signupViewModel = SignupViewModel()
        signupModel = SignupModel(firstName: "", lastName: "", emailAddress: "", password: "", confirmPassword: "")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signupViewModel = nil
        signupModel = nil
    }
    
    func testLoginObjectNotNil() {
        XCTAssertNotNil(signupViewModel)
        XCTAssertNotNil(signupModel)
    }
    
    func testValidateFirstName() {
        signupModel?.firstName = ""
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateLastName() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = ""
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateEmptyEmail() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = ""
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateInvalidEmail() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "adsdas@gmail"
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateValidEmail() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateEmptyPassword() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        signupModel?.password = ""
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateEmptyConfirmPassword() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        signupModel?.password = "AbcXYz"
        signupModel?.confirmPassword = ""
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateMismatchPasswordConfirmPassword() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        signupModel?.password = "AbcXYz"
        signupModel?.confirmPassword = "ZYXAbc"
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateMatchPasswordConfirmPassword() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        signupModel?.password = "AbcXYz"
        signupModel?.confirmPassword = "AbcXYz"
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertTrue(status)
        XCTAssertNotNil(message)
    }
    
    func testValidateSingupData() {
        signupModel?.firstName = "Dhaval"
        signupModel?.lastName = "Sabhaya"
        signupModel?.emailAddress = "dhaval.sabhaya@volansys.com"
        signupModel?.password = "AbcXYz"
        signupModel?.confirmPassword = "AbcXYz"
        let (status, message) = signupViewModel!.validateSignupData(signupModel: signupModel!)
        XCTAssertTrue(status)
        XCTAssertNotNil(message)
    }    
    
}
