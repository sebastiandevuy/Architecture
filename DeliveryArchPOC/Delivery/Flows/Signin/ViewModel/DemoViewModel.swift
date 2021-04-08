//
//  DemoViewModel.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation

class DemoViewModel: ViewModelable {
    private let navigator: NavigatorProtocol
    private let controllerFactory: ViewControllerFactoryProtocol
    
    var viewState = Viewstate()
    var modelState = ModelState()
    
    init(navigator: NavigatorProtocol = Navigator(),
         controllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()) {
        self.navigator = navigator
        self.controllerFactory = controllerFactory
    }
    
    func dispatchInputAction(_ action: InputAction) {
        switch action {
        case .didSucceedSigningIn:
            handleDidSucceedSigningIn()
        case .didFailSigningIn:
            handleDidFailSigningIn()
        }
    }
    
    private func handleDidSucceedSigningIn() {
        navigator.presentControllerOnTop(controller: controllerFactory.create(.loginSuccess), presentationStyle: .fullScreen)
    }
    
    private func handleDidFailSigningIn() {
        navigator.presentControllerOnTop(controller: controllerFactory.create(.alert(title: "Sign in failure",
                                                                                     message: "We could not sign you in",
                                                                                     action: "OK",
                                                                                     hanlder: { _ in
            print("User Tapped OK...analytics or something?")
                                                                                     })), presentationStyle: .fullScreen)
    }
}

extension DemoViewModel {
    enum InputAction: Equatable {
        case didSucceedSigningIn
        case didFailSigningIn
    }
    class Viewstate {}
    class ModelState {}
}
