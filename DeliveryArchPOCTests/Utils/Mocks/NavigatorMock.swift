//
//  NavigatorMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 30/3/21.
//

import Foundation
import UIKit
@testable import DeliveryArchPOC

class NavigatorMock: NavigatorProtocol {
    private var receivedViewControllerToPresent: UIViewController?
    private var receivedPresentationStyle: NavigatorPresentationStyle?
    
    func presentControllerOnTop(controller: UIViewController,
                                presentationStyle: NavigatorPresentationStyle) {
        receivedViewControllerToPresent = controller
        receivedPresentationStyle = presentationStyle
    }
    
    func didReceive(controller: UIViewController,
                    withPresentationStyle style: NavigatorPresentationStyle) -> Bool {
        return receivedViewControllerToPresent == controller && receivedPresentationStyle == style
    }
}
