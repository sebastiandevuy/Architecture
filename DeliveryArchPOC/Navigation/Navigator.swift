//
//  Navigator.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation
import UIKit

protocol NavigatorProtocol {
    func presentControllerOnTop(controller: UIViewController,
                                presentationStyle: NavigatorPresentationStyle)
}

/// Object in charge of all top level app navigation coordination
class Navigator: NavigatorProtocol {
    
    /// Presents controller over the top most presented controller, wrapped inside a navigation controller
    /// - Parameter controller: controller to present
    func presentControllerOnTop(controller: UIViewController,
                                presentationStyle: NavigatorPresentationStyle = .fullScreen) {
        guard let topController = getTopViewController() else { return }
        if let alertController = controller as? UIAlertController {
            topController.present(alertController, animated: true, completion: nil)
            return
        }
        let navigationWrapper = UINavigationController(rootViewController: controller)
        
        switch presentationStyle {
        case .push:
            if let topNavigationController = topController as? UINavigationController {
                topNavigationController.pushViewController(navigationWrapper, animated: true)
            } else {
                //Fallback if there is no Navigation Controller on top
                topController.present(navigationWrapper, animated: true)
            }
        case .fullScreen:
            navigationWrapper.modalPresentationStyle = .fullScreen
            topController.present(navigationWrapper, animated: true)
        case .modal:
            topController.present(navigationWrapper, animated: true)
        }
    }
}

private extension Navigator {
    func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}

enum NavigatorPresentationStyle {
    case push
    case modal
    case fullScreen
}
