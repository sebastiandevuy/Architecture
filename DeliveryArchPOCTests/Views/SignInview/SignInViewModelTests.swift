//
//  SignInViewModelTests.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 28/3/21.
//  
//

import Quick
import Nimble
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
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserPassword(password: validPassword))
                        }
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.password.get()).to(equal(validPassword))
                            expect(subject.modelState.isValidPassword).to(beTrue())
                        }
                    }
                }
                
                context("with invalid user password") {
                    let invalidPassword = "pass"
                    
                    beforeEach {
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserPassword(password: invalidPassword))
                        }
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.password.get()).to(equal(invalidPassword))
                            expect(subject.modelState.isValidPassword).to(beFalse())
                        }
                    }
                }
            }
            
            // MARK: - didTapSignIn
            context("didTapSignIn") {
                
                context("with valid username and password") {
                    beforeEach {
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserName(userName: "dummyUser"))
                            subject.dispatchInputAction(.didUpdateUserPassword(password: "dummypass"))
                            subject.dispatchInputAction(.didTapSignIn)
                        }
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.userName.get()).to(equal("dummyUser"))
                            expect(subject.modelState.isValidUserName).to(beTrue())
                            
                            expect(subject.viewState.password.get()).to(equal("dummypass"))
                            expect(subject.modelState.isValidPassword).to(beTrue())
                            
                            expect(signInManagerMock.resolveSignIn(withResult: .success(true))).to(beTrue())   //CHECK THIS
                        }
                    }
                }
                
                context("with invalid username and password") {
                    beforeEach {
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
            }
            
            // MARK: - didEndEditingUser
            context("didEndEditingUser") {
                
                context("with empty username") {
                    beforeEach {
                        subject.dispatchInputAction(.didEndEditingUser)
                        
                        it("should set ViewState value and validate") {
                            expect(subject.viewState.userName.get()).to(equal(""))
                            expect(subject.modelState.isValidUserName).to(beTrue())
                        }
                    }
                }
            }
        }
    }
}
