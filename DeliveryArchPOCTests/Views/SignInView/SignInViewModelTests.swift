//
//  SignInViewModelTests.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 28/3/21.
//  
//

import Quick
import Nimble
import Foundation
@testable import DeliveryArchPOC

class SignInViewModelTests: QuickSpec {
    override func spec() {
        var subject: SignInViewModel!
        var localizableMock: LocalizableManagerMock!
        var signInManagerMock: SignInManagerMock!
        let testText = "My test text"
        
        beforeEach {
            localizableMock = LocalizableManagerMock()
            localizableMock.dummyReturnValue = testText
            signInManagerMock = SignInManagerMock()
            subject = SignInViewModel(localizableManager: localizableMock,
                                      signInManager: signInManagerMock)
        }
        
        describe("input actions") {
            // MARK: - didInit
            context("didInit") {
                beforeEach {
                    subject.dispatchInputAction(.didInit)
                }
                
                it("should setup ViewState localizable properties") {
                    expect(subject.viewState.userLabelText).to(equal(testText))
                    expect(subject.viewState.passwordLabelText).to(equal(testText))
                    expect(subject.viewState.userPlaceHolderText).to(equal(testText))
                    expect(subject.viewState.passwordPlaceHolderText).to(equal(testText))
                    expect(subject.viewState.signInButtonTitle).to(equal(testText))
                    
                    expect(localizableMock.didReceiveLocalizableKey(.userTitle)).to(beTrue())
                    expect(localizableMock.didReceiveLocalizableKey(.passwordTitle)).to(beTrue())
                    expect(localizableMock.didReceiveLocalizableKey(.userPlaceHolder)).to(beTrue())
                    expect(localizableMock.didReceiveLocalizableKey(.passwordPlaceHolder)).to(beTrue())
                    expect(localizableMock.didReceiveLocalizableKey(.signIn)).to(beTrue())
                }
            }
            
            // MARK: - didUpdateUserName
            context("didUpdateUserName") {
                context("with valid user name") {
                    beforeEach {
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserName(userName: "dummyUser"))
                        }
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.userName.get()).to(equal("dummyUser"))
                            expect(subject.modelState.isValidUserName).to(beTrue())
                        }
                    }
                }
                
                context("with invalid user name") {
                    beforeEach {
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserName(userName: "dummy"))
                        }
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.userName.get()).to(equal("dummy"))
                            expect(subject.modelState.isValidUserName).to(beFalse())
                        }
                    }
                }
            }
            
            // MARK: - didUpdateUserPassword
            context("didUpdateUserPassword") {
                let validPassword = "dummypass"
                
                context("with valid user password") {
                    beforeEach {
                        subject.dispatchInputAction(.didUpdateUserPassword(password: validPassword))
                    }
                    
                    it("should set ViewState value and validate") {
                        expect(subject.viewState.password.get()).to(equal(validPassword))
                        expect(subject.modelState.isValidPassword).to(beTrue())
                    }
                }
                
                context("with invalid user password") {
                    let invalidPassword = "pass"
                    
                    beforeEach {
                        subject.dispatchInputAction(.didUpdateUserPassword(password: invalidPassword))
                    }
                    
                    it("should set ViewState value and validate") {
                        expect(subject.viewState.password.get()).to(equal(invalidPassword))
                        expect(subject.modelState.isValidPassword).to(beFalse())
                    }
                    
                }
            }
            
            // MARK: - didTapSignIn
            context("didTapSignIn") {
                
                context("with valid username and password") {
                    
                    beforeEach {
                        subject.modelState.isValidPassword = true
                        subject.modelState.isValidUserName = true
                        subject.viewState.userName.set(newValue: "dummy")
                        subject.viewState.password.set(newValue: "dummy")
                        subject.dispatchInputAction(.didTapSignIn)
                    }
                    
                    it("should set ViewState value and validate") {
                        expect(subject.viewState.isLoading.get()).to(beTrue())
                    }
                    
                    context("the service call") {
                        context("succeeds") {
                            beforeEach {
                                signInManagerMock.resolveSignIn(withResult: .success(true))
                            }
                            
                            it("should set the correct signinResult") {
                                expect(subject.viewState.signInResult.get()).to(equal(.success))
                                expect(subject.viewState.isLoading.get()).to(beFalse())
                            }
                        }
                        
                        context("fails") {
                            beforeEach {
                                signInManagerMock.resolveSignIn(withResult: .failure(NSError(domain: "", code: 1, userInfo: nil)))
                            }
                            
                            it("should set the correct signinResult") {
                                expect(subject.viewState.signInResult.get()).to(equal(.failed))
                                expect(subject.viewState.isLoading.get()).to(beFalse())
                            }
                        }
                    }
                    
                }
                
                context("with invalid username and password") {
                    beforeEach {
                        subject.dispatchInputAction(.didUpdateUserName(userName: "dummy"))
                        subject.dispatchInputAction(.didUpdateUserPassword(password: "pass"))
                        subject.dispatchInputAction(.didTapSignIn)
                    }
                    
                    it("should set ViewState value and validate") {
                        expect(subject.modelState.isValidUserName).to(beFalse())
                        expect(subject.modelState.isValidPassword).to(beFalse())
                        expect(subject.viewState.isLoading.get()).to(beNil())
                    }
                    
                }
            }
            
            // MARK: - didEndEditingUser
            context("didEndEditingUser") {
                
                context("with empty username") {
                    beforeEach {
                        subject.viewState.userName.set(newValue: "")
                        subject.dispatchInputAction(.didEndEditingUser)
                        subject.viewState.userError.set(newValue: "Insuficiente cantidad de caracteres en user")
                    }
                    
                    it("should set ViewState value and validate") {
                        expect(subject.modelState.isValidUserName).to(beFalse())
                        expect(subject.viewState.userError.get()).to(equal("Insuficiente cantidad de caracteres en user"))
                    }
                    
                }
            }
        }
    }
}
