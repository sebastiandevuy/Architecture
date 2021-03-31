//
//  DemoViewModelMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 30/3/21.
//

import Foundation
@testable import DeliveryArchPOC

class DemoViewModelMock: DemoViewModel {
    private var receivedActions = [DemoViewModel.InputAction]()
    
    override func dispatchInputAction(_ action: DemoViewModel.InputAction) {
        receivedActions.append(action)
    }
    
    func didReceiveAction(_ action: DemoViewModel.InputAction) -> Bool {
        return receivedActions.contains(action)
    }
    
    func reset() {
        receivedActions.removeAll()
    }
}
