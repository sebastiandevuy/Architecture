//
//  ViewControllerFactory.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation
import UIKit

protocol ViewControllerFactoryProtocol {
    func create(_ controller: ViewControllerFactory.Controller) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    func create(_ controller: ViewControllerFactory.Controller) -> UIViewController {
        switch controller {
        case .demo:
            return DemoViewControllerBuilder().build()
        case .loginSuccess:
            return SuccessViewController()
        case .alert(let title, let message, let action, let handler):
            let action = UIAlertAction(title: action, style: .default, handler: handler)
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
    }
}

extension ViewControllerFactory {
    // Pass parameters and delegates if needed as enum params
    enum Controller {
        case demo
        case loginSuccess
        case alert(title: String, message: String, action: String, hanlder: (UIAlertAction) -> Void )
    }
}

