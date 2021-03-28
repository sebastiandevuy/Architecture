//
//  ViewModellable.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation

protocol ViewModelable {
    // Actions to be received by the controller in reponse to user input or events
    associatedtype InputAction: Equatable
    
    // Variables and observables related to the View
    associatedtype ViewState
    
    // Variables related to the model
    associatedtype ModelState
    
    func dispatchInputAction(_ action: InputAction)
    //Convention based. Views should never update viewstate or modelState
    var viewState: ViewState { get }
    var modelState: ModelState { get }
}
