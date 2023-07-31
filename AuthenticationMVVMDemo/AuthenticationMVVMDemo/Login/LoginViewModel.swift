//
//  LoginViewModel.swift
//  AuthenticationMVVMDemo
//
//  Created by Dhaval.Sabhaya on 06/07/22.
//

import Foundation

class LoginViewModel: NSObject {
        
    func validateLoginData(loginModel: LoginModel) -> (Bool, String) {
        guard let trimmedEmail = loginModel.userName?.trimLeadingOrTrailingSpace(), !trimmedEmail.isEmpty else {
            return (false, AppString.Login.emptyUsername)
        }
        
        if !DataValidator.checkEmailValid(trimmedEmail) {
            return (false, AppString.Login.invalidUsername)
        }
        
        guard let trimmedPassword = loginModel.password?.trimLeadingOrTrailingSpace(), !trimmedPassword.isEmpty else {
            return (false, AppString.Login.emptyPassword)
        }
        
        return (true, "")
    }
    
    func authenticateUser(request: LoginRequest, completionHandler: @escaping(_ loginData: LoginData?)->()) {
        authenticateUser1(request: request) { (response) in
            // return it back to the caller
            completionHandler(LoginData(errorMessage: nil, response: response))
        }
    }
    
    func authenticateUser1(request: LoginRequest, completionHandler: @escaping(_ result: LoginResponse?)->()) {

        let urlRequest = generateLoginUrlRequest(request: request)

        URLSession.shared.dataTask(with: urlRequest) { (responseData, serverResponse, serverError) in
            if(serverError == nil && responseData != nil) {
                do {
                    let result = try JSONDecoder().decode(LoginResponse.self, from: responseData!)
                    completionHandler(result)
                } catch  {
                    debugPrint("Encoding request body failed")
                }
            }
        }.resume()
    }

    private func generateLoginUrlRequest(request: LoginRequest) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        urlRequest.httpMethod = "post"

        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch  {
            debugPrint("Encoding request body failed")
        }

        urlRequest.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "content-type")
        return urlRequest
    }
    
    func apiCallFromPostManCode(requestData: LoginRequest, completionHandler: @escaping(_ result: LoginResponseData?)->()) {
        let semaphore = DispatchSemaphore (value: 0)// ?title=abc&body=xyz&userId=2

        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONEncoder().encode(requestData)
        } catch  {
            debugPrint("Encoding request body failed")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .topLevelDictionaryAssumed) as? [String : Any]
                print("JSON == \(json)")
            }catch{ print("erroMsg") }
            
            do {
                let result = try JSONDecoder().decode(LoginResponseData.self, from: data)
                completionHandler(result)
            } catch  {
                debugPrint("Encoding request body failed")
            }
        }

        task.resume()
        semaphore.wait()
    }
    
}

