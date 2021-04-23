//
//  DemoViewControllerBuilder.swift
//  DeliveryArchPOC
//
//  Created by Erik Flores on 4/14/21.
//

import Foundation

class DemoViewControllerBuilder {
    let signInRepository: SignInRepository
    let navigator: NavigatorProtocol
    let controllerFactory: ViewControllerFactoryProtocol

    init(signInRepository: SignInRepository = DefaultSignInRepository(),
         navigatorProtocol: NavigatorProtocol = Navigator(),
         viewControllerFactoryProtocol: ViewControllerFactoryProtocol = ViewControllerFactory()) {
        self.signInRepository = signInRepository
        self.navigator = navigatorProtocol
        self.controllerFactory = viewControllerFactoryProtocol
    }

    func build() -> DemoViewController {
        let signInViewModel = SignInViewModel(signInRepository: signInRepository)
        let signInView = SignInView(viewModel: signInViewModel)
        let viewModel = DemoViewModel(navigator: navigator,
                                      controllerFactory: controllerFactory)
        let viewController = DemoViewController(viewModel: viewModel,
                                                signInView: signInView)
        return viewController
    }

}
