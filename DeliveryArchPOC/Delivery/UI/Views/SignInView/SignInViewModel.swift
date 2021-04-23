//
//  SignInViewModel.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation

class SignInViewModel: ViewModelable {
    private let localizableManager: DummyLocalizableManagerProtocol
    private let signInRepository: SignInRepository
    
    var viewState = Viewstate()
    var modelState = ModelState()
    
    init(localizableManager: DummyLocalizableManagerProtocol = DummyLocalizableManager(),
         signInRepository: SignInRepository) {
        self.localizableManager = localizableManager
        self.signInRepository = signInRepository
    }
    
    func dispatchInputAction(_ action: InputAction) {
        switch action {
        case .didInit:
            handleDidInit()
        case .didUpdateUserName(let userName):
            handleDidUpdateUserName(userName)
        case .didUpdateUserPassword(let password):
            handleDidUpdatePassword(password)
        case .didTapSignIn:
            handleDidTapSignIn()
        case .didEndEditingUser:
            handleDidEndEditingUser()
        case .didEndEditingPassword:
            handleDidendEditingPassword()
        }
    }
    
    
    private func handleDidInit() {
        viewState.userLabelText = localizableManager.localizable(forKey: .userTitle)
        viewState.passwordLabelText = localizableManager.localizable(forKey: .passwordTitle)
        viewState.userPlaceHolderText = localizableManager.localizable(forKey: .userPlaceHolder)
        viewState.passwordPlaceHolderText = localizableManager.localizable(forKey: .passwordPlaceHolder)
        viewState.signInButtonTitle = localizableManager.localizable(forKey: .signIn)
    }
    
    private func handleDidUpdateUserName(_ userName: String) {
        viewState.userName.set(newValue: userName)
        evaluateUserNameIsValid()
    }
    
    private func handleDidUpdatePassword(_ password: String) {
        viewState.password.set(newValue: password)
        evaluatePasswordIsValid()
    }
    
    private func handleDidEndEditingUser() {
        guard let userName = viewState.userName.get(), !userName.isEmpty else {
            viewState.userError.set(newValue: nil)
            return
        }
        evaluateUserError()
    }
    
    private func handleDidendEditingPassword() {
        guard let password = viewState.password.get(), !password.isEmpty else {
            viewState.passwordError.set(newValue: nil)
            return
        }
        evaluatePasswordError()
    }
    
    private func evaluateUserError() {
        if modelState.isValidUserName {
            viewState.userError.set(newValue: nil)
        } else {
            viewState.userError.set(newValue: "Insuficiente cantidad de caracteres en user")
        }
    }
    
    private func evaluatePasswordError() {
        if modelState.isValidPassword {
            viewState.passwordError.set(newValue: nil)
        } else {
            viewState.passwordError.set(newValue: "Insuficiente cantidad de caracteres en password")
        }
    }
    
    private func evaluateUserNameIsValid() {
        guard let userName = viewState.userName.get() else {
            modelState.isValidUserName = false
            return
        }
        modelState.isValidUserName = userName.count >= modelState.minCharacterCount
    }
    
    private func evaluatePasswordIsValid() {
        guard let password = viewState.password.get() else {
            modelState.isValidPassword = false
            return
        }
        modelState.isValidPassword = password.count >= modelState.minCharacterCount
    }
    
    private func handleDidTapSignIn() {
        guard modelState.isValidPassword, modelState.isValidUserName else {
            evaluateUserError()
            evaluatePasswordError()
            return
        }
        viewState.isLoading.set(newValue: true)
        signInRepository.execute(user: viewState.userName.get()!,
                             password: viewState.password.get()!) { [weak self] result in
            self?.viewState.isLoading.set(newValue: false)
            switch result {
            case .success(_):
                self?.viewState.signInResult.set(newValue: .success)
            case .failure(_):
                self?.viewState.signInResult.set(newValue: .failed)
            }
        }
    }
}

extension SignInViewModel {
    enum InputAction: Equatable {
        case didInit
        case didUpdateUserName(userName: String)
        case didUpdateUserPassword(password: String)
        case didTapSignIn
        case didEndEditingUser
        case didEndEditingPassword
    }
    
    class Viewstate {
        var userLabelText = ""
        var passwordLabelText = ""
        var userPlaceHolderText = ""
        var passwordPlaceHolderText = ""
        var signInButtonTitle = ""
        var userName = ViewObservable<String>(nil)
        var password = ViewObservable<String>(nil)
        var userError = ViewObservable<String>(nil)
        var passwordError = ViewObservable<String>(nil)
        var isLoading = ViewObservable<Bool>(nil)
        var signInResult = ViewObservable<SignInView.SignInResult>(nil)
    }
    
    class ModelState {
        let minCharacterCount = 6
        var isValidUserName = false
        var isValidPassword = false
    }
}
