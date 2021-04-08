//
//  TestControllerPresenter.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 30/3/21.
//

import Foundation
import UIKit

class TestControllerPresenter {
    
    static func presentController(_ controller: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = controller
        _ = controller.view
        controller.children.forEach({ _ = $0.view })
    }
}
