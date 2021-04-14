//
//  DemoViewControllerBuilder.swift
//  DeliveryArchPOC
//
//  Created by Erik Flores on 4/14/21.
//

import Foundation

class DemoViewControllerBuilder {

    func build() -> DemoViewController {
        let viewModel = DemoViewModel(navigator: navigator,
                                      controllerFactory: controllerFactory)
        let viewController = DemoViewController(viewModel: viewModel, signInView: signInView)
        return viewController
    }

    private var repository: SignInRepository {
        return DefaultSignInRepository()
    }

    private var signInAction: SignInAction {
        return DefaultSignInAction(repository: repository)
    }

    private var signInViewModel: SignInViewModel {
        return SignInViewModel(signInAction: signInAction)
    }

    private var signInView: SignInView {
        return SignInView(viewModel: signInViewModel)
    }

    private var navigator: NavigatorProtocol {
        return Navigator()
    }

    private var controllerFactory: ViewControllerFactoryProtocol {
        return ViewControllerFactory()
    }

}
