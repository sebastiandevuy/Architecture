//
//  SignInAction.swift
//  DeliveryArchPOC
//
//  Created by Erik Flores on 4/13/21.
//

import Foundation

protocol SignInAction {
    func execute(user: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DefaultSignInAction: SignInAction {
    private let repository: SignInRepository

    init(repository: SignInRepository) {
        self.repository = repository
    }

    func execute(user: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.execute(user: user, password: password, completion: completion)
    }
}
