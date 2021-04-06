//
//  SignInViewModelMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 5/4/21.
//

import Foundation
@testable import DeliveryArchPOC

class SignInViewModelMock: SignInViewModel {
    private var receivedActions = [SignInViewModel.InputAction]()
    
    override func dispatchInputAction(_ action: SignInViewModel.InputAction) {
        receivedActions.append(action)
    }
    
    func didReceiveAction(_ action: SignInViewModel.InputAction) -> Bool {
        return receivedActions.contains(action)
    }
    
    func reset() {
        receivedActions.removeAll()
    }
}
