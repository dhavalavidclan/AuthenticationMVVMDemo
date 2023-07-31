//
//  LoginResponse.swift
//  TestCaseDemo
//
//  Created by CodeCat15 on 12/24/20.
//

import Foundation

struct LoginResponse : Codable {

    let errorMessage: String?
    let data: LoginResponseData?
}

struct LoginResponseData : Codable {
    let title: String
    let userID: Int
    let id: Int
    let body: String

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case id
        case userID
    }
}
