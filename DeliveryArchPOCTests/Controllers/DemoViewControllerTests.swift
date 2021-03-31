//
//  DemoViewControllerTests.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 30/3/21.
//  
//

import Quick
import Nimble
@testable import DeliveryArchPOC

class DemoViewControllerTests: QuickSpec {
    override func spec() {
        var subject: DemoViewController!
        var viewModelMock: DemoViewModelMock!
        var navigatorMock: NavigatorMock!
        var controllerFactoryMock: ViewControllerFactoryMock!
        var signInView: SignInView?
        
        beforeEach {
            navigatorMock = NavigatorMock()
            controllerFactoryMock = ViewControllerFactoryMock()
            viewModelMock = DemoViewModelMock(navigator: navigatorMock,
                                              controllerFactory: controllerFactoryMock)
            subject = DemoViewController(viewModel: viewModelMock)
            TestControllerPresenter.presentController(subject)
            signInView = subject.view.subviews.first as? SignInView
        }
        
        describe("initialization and initial load") {
            it("should setup view") {
                expect(signInView).toNot(beNil())
                expect(subject.view.backgroundColor).to(equal(.white))
            }
            
            describe("bindings") {
                context("with success") {
                    beforeEach {
                        signInView?.userSignInResult.set(newValue: .success)
                    }
                    
                    it("should trigger the appropriate viewmodel action") {
                        expect(viewModelMock.didReceiveAction(.didSucceedSigningIn)).to(beTrue())
                    }
                }
                
                context("with failure") {
                    beforeEach {
                        signInView?.userSignInResult.set(newValue: .failed)
                    }
                    
                    it("should trigger the appropriate viewmodel action") {
                        expect(viewModelMock.didReceiveAction(.didFailSigningIn)).to(beTrue())
                    }
                }
            }
        }
    }
}
