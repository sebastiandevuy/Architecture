//
//  SignInViewTests.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 5/4/21.
//  
//

import Quick
import Nimble
import UIKit
@testable import DeliveryArchPOC

class SignInViewTests: QuickSpec {
    override func spec() {
        var subject: SignInView!
        var viewModelMock: SignInViewModelMock!
        var localizableMock: LocalizableManagerMock!
        var signInManagerMock: SignInManagerMock!
        
        var stackView: UIStackView?
        var userLabel: UILabel?
        var userErrorLabel: UILabel?
        var userTextfield: UITextField?
        var passwordLabel: UILabel?
        var passwordErrorLabel: UILabel?
        var passwordTextField: UITextField?
        var signInButton: UIButton?
        var activityIndicator: UIActivityIndicatorView?
        
        beforeEach {
            localizableMock = LocalizableManagerMock()
            signInManagerMock = SignInManagerMock()
            viewModelMock = SignInViewModelMock(localizableManager: localizableMock,
                                                signInManager: signInManagerMock)
            
            viewModelMock.viewState.userLabelText = "dummy user label"
            viewModelMock.viewState.passwordLabelText = "dummy password text"
            viewModelMock.viewState.passwordPlaceHolderText = "dummy password placeholder text"
            viewModelMock.viewState.signInButtonTitle = "dummy sign in button"
            viewModelMock.viewState.userPlaceHolderText = "dummy user placeholder text"
            
            subject = SignInView(viewModel: viewModelMock)
            
            stackView = subject.subviews[0] as? UIStackView
            userLabel = stackView?.arrangedSubviews[0] as? UILabel
            userErrorLabel = stackView?.arrangedSubviews[1] as? UILabel
            userTextfield = stackView?.arrangedSubviews[2] as? UITextField
            passwordLabel = stackView?.arrangedSubviews[3] as? UILabel
            passwordErrorLabel = stackView?.arrangedSubviews[4] as? UILabel
            passwordTextField = stackView?.arrangedSubviews[5] as? UITextField
            signInButton = stackView?.arrangedSubviews[6] as? UIButton
            activityIndicator = stackView?.arrangedSubviews[7] as? UIActivityIndicatorView
            
        }
        
        describe("initialization") {
            it("should dispatch init action") {
                expect(viewModelMock.didReceiveAction(.didInit)).to(beTrue())
            }
            
            it("should setup view") {
                expect(userLabel?.text).to(equal("dummy user label"))
                expect(userLabel?.font).to(equal(.boldSystemFont(ofSize: 14)))
                
                expect(userTextfield?.placeholder).to(equal("dummy user placeholder text"))
                expect(userTextfield?.autocorrectionType).to(equal(.no))
                expect(userTextfield?.tag).to(equal(1))
                
                expect(passwordLabel?.text).to(equal("dummy password text"))
                expect(passwordTextField?.placeholder).to(equal("dummy password placeholder text"))
                expect(signInButton?.currentTitle).to(equal("dummy sign in button"))
                //TODO: All other view tests below
            }
            
            context("the bindings") {
                context("userName") {
                    beforeEach {
                        viewModelMock.viewState.userName.set(newValue: "Igor")
                    }
                    
                    it("should set the user textField value") {
                        expect(userTextfield?.text).to(equal("Igor"))
                    }
                }
                
                context("password") {
                    beforeEach {
                        viewModelMock.viewState.password.set(newValue: "securePass")
                    }
                    
                    it("should set the user textField value") {
                        expect(passwordTextField?.text).to(equal("securePass"))
                    }
                }
                
                context("userError") {
                    context("error is not nil") {
                        beforeEach {
                            viewModelMock.viewState.userError.set(newValue: "dummy error")
                        }
                        
                        it("should set the user textField value") {
                            expect(userErrorLabel?.text).to(equal("dummy error"))
                            expect(userErrorLabel?.isHidden).to(beFalse())
                        }
                    }
                    
                    context("error is nil") {
                        beforeEach {
                            viewModelMock.viewState.userError.set(newValue: nil)
                        }
                        
                        it("should set the user textField value") {
                            expect(userErrorLabel?.text).to(beNil())
                            expect(userErrorLabel?.isHidden).to(beTrue())
                        }
                    }
                }
                
                //TODO: All other bindings tests below
            }
        }
    }
}
