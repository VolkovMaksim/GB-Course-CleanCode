//
//  ReistrationTest.swift
//  GB-Course-CleanCodeTests
//
//  Created by Maksim Volkov on 06.07.2022.
//

import XCTest
@testable import GB_Course_CleanCode

class ReistrationTest: XCTestCase {
    
    var registeration: Registration!

    override func setUpWithError() throws {
        registeration = Registration()
    }

    override func tearDownWithError() throws {
        registeration = nil
    }

    func test_comparePassword() {
        //Given
        let password = "123"
        let confirmPasword = "123"
        
        //When
        let registr = registeration.comparePassword(password: password, confirmPassword: confirmPasword)
        
        //Then
        XCTAssert(registr == true, registr.description)
        
    }
    
    func test_registrationUser() {
        //Given
        
        //When
        let saveUserData = registeration.registrationUser()
        
        //Then
        XCTAssert(saveUserData == true, saveUserData.description)
        
    }

}
