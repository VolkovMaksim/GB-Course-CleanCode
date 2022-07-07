//
//  AuthorizationTest.swift
//  GB-Course-CleanCodeTests
//
//  Created by Maksim Volkov on 07.07.2022.
//

import XCTest
@testable import GB_Course_CleanCode

class AuthorizationTest: XCTestCase {
    var authorization: Authorization!

    override func setUpWithError() throws {
        authorization = Authorization()
    }

    override func tearDownWithError() throws {
        authorization = nil
    }

    func testExample() throws {
        let email = "admin@admin.ru"
        
        guard let userPass = Registration().registeredUsers.string(forKey: email) else { return }
        
        let checkUser = authorization.tryLogin(userPass: userPass)
        
        XCTAssert(checkUser == true, checkUser.description)
    }

}
