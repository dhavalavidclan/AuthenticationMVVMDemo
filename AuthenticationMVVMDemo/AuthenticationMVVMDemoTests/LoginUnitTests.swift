//
//  LoginUnitTests.swift
//  AuthenticationMVVMDemoTests
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import XCTest

class LoginUnitTests: XCTestCase {
    
    private var loginViewModel: LoginViewModel?
    private var loginModel: LoginModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginViewModel = LoginViewModel()
        loginModel = LoginModel(userName: "", password: "")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginViewModel = nil
        loginModel = nil
    }
    
    func testLoginObjectNotNil() {
        XCTAssertNotNil(loginViewModel)
        XCTAssertNotNil(loginModel)
    }
    
    func testValidateEmptyUsername() {
        loginModel?.userName = ""
        let (status, message) = loginViewModel!.validateLoginData(loginModel: loginModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
        XCTAssertEqual(message, message)
    }
    
    func testValidateInvalidUsername() {
        loginModel?.userName = "test@test"
        let (status, message) = loginViewModel!.validateLoginData(loginModel: loginModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
        XCTAssertEqual(message, message)
    }
    
    func testValidateEmptyPassword() {
        loginModel?.userName = "dhaval.sabhaya@volansys.com"
        loginModel?.password = ""
        let (status, message) = loginViewModel!.validateLoginData(loginModel: loginModel!)
        XCTAssertFalse(status)
        XCTAssertNotNil(message)
        XCTAssertEqual(message, message)
    }

    func testValidateLoginData() {
        loginModel?.userName = "dhaval.sabhaya@volansys.com"
        loginModel?.password = "Test@123"
        let (status, message) = loginViewModel!.validateLoginData(loginModel: loginModel!)
        XCTAssertTrue(status)
        XCTAssertNotNil(message)
        XCTAssertEqual(message, message)
    }
    
    func test_LoginApiResource_With_ValidRequest_Returns_LoginResponse() {
        
        let request = LoginRequest(title: "ABC Title", body: "XYZ Body", userId: 1)
        
        let expectation = self.expectation(description: "ValidRequest_Returns_LoginResponse")

        loginViewModel!.apiCallFromPostManCode(requestData: request) { (loginResponse) in
            print("loginResponse = \(loginResponse.debugDescription)")
            
            XCTAssertNotNil(loginResponse)
            //XCTAssertNil(loginResponse?.errorMessage)
            XCTAssertEqual(request.userId, loginResponse?.userID)
            XCTAssertEqual("codecat15", loginResponse?.title)
            XCTAssertEqual(15, loginResponse?.id)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)

    }

    
}
