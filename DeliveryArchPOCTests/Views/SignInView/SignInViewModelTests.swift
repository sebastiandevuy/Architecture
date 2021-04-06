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
            context("didInit") {
                beforeEach {
                    subject.dispatchInputAction(.didInit)
                }
                
                it("should setup viewstate localizable properties") {
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
            
            context("didUpdateUserName") {
                context("with valid user name") {
                    beforeEach {
                        beforeEach {
                            subject.dispatchInputAction(.didUpdateUserName(userName: "dummyUser"))
                        }
                        
                        it("should set viewstate value and validate") {
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
                        
                        it("should set viewstate value and validate") {
                            expect(subject.viewState.userName.get()).to(equal("dummy"))
                            expect(subject.modelState.isValidUserName).to(beFalse())
                        }
                    }
                }
            }
        }
    }
}
