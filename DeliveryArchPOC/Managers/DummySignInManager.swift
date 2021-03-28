//
//  DummySignInManager.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 28/3/21.
//

import Foundation

protocol DummySingInManagerProtocol {
    func signIn(userName: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DummySignInManager: DummySingInManagerProtocol {
    func signIn(userName: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5) {
            if userName == "dummyuser" && password == "dummypass" {
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "auth domain", code: -1, userInfo: nil)))
            }
        }
    }
}
