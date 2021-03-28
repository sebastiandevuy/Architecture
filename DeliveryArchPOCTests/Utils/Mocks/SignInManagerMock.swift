//
//  SignInManagerMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 28/3/21.
//

import Foundation
@testable import DeliveryArchPOC

class SignInManagerMock: DummySingInManagerProtocol {
    private var completion: ((Result<Bool, Error>) -> Void)?
    
    func signIn(userName: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.completion = completion
    }
    
    func resolveSignIn(withResult result: Result<Bool, Error>) {
        completion?(result)
    }
}
