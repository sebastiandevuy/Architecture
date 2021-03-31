//
//  ViewControllerFactoryMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 30/3/21.
//

import Foundation
import UIKit
@testable import DeliveryArchPOC

class ViewControllerFactoryMock: ViewControllerFactoryProtocol {
    var receivedControllerToCreate: ViewControllerFactory.Controller?
    
    func create(_ controller: ViewControllerFactory.Controller) -> UIViewController {
        receivedControllerToCreate = controller
        return UIViewController()
    }
}
