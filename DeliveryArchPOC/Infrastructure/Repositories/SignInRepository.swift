//
//  SignInRepository.swift
//  DeliveryArchPOC
//
//  Created by Erik Flores on 4/13/21.
//

import Foundation

protocol SignInRepository {
    func execute(user: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DefaultSignInRepository: SignInRepository {
    func execute(user: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5) {
            if user == "dummyuser" && password == "dummypass" {
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "auth domain", code: -1, userInfo: nil)))
            }
        }
    }
}
