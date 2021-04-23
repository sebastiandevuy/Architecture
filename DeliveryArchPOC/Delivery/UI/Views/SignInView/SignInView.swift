//
//  SignInView.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation
import UIKit

class SignInView: UIView {
    private let viewModel: SignInViewModel
    private let stackView = UIStackView()
    private let userLabel = UILabel()
    private let passwordLabel = UILabel()
    private let userErrorLabel = UILabel()
    private let passwordErrorLabel = UILabel()
    private let userTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signInButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var userSignInResult = ViewObservable<SignInResult>(nil)
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.dispatchInputAction(.didInit)
        setupView()
        setupBindings()
    }
    
    private func setupView() {
        stackView.axis = .vertical
        stackView.spacing = 6
        addSubview(stackView)

        stackView.addConstraints(topAnchor,
                                 left: leftAnchor,
                                 bottom: bottomAnchor,
                                 right: rightAnchor,
                                 topConstant: 8,
                                 leftConstant: 8,
                                 bottomConstant: 8,
                                 rightConstant: 8)
        
        userLabel.text = viewModel.viewState.userLabelText
        userLabel.font = .boldSystemFont(ofSize: 14)
        passwordLabel.text = viewModel.viewState.passwordLabelText
        passwordLabel.font = .boldSystemFont(ofSize: 14)
        userErrorLabel.font = .italicSystemFont(ofSize: 10)
        userErrorLabel.textColor = .red
        passwordErrorLabel.font = .italicSystemFont(ofSize: 10)
        passwordErrorLabel.textColor = .red
        
        userTextField.placeholder = viewModel.viewState.userPlaceHolderText
        userTextField.autocorrectionType = .no
        userTextField.tag = 1
        userTextField.autocapitalizationType = .none
        userTextField.delegate = self
        
        passwordTextField.placeholder = viewModel.viewState.passwordPlaceHolderText
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tag = 2
        passwordTextField.delegate = self
        
        signInButton.setTitle(viewModel.viewState.signInButtonTitle, for: .normal)
        signInButton.addTarget(self, action: #selector(onSignInButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(userLabel)
        stackView.addArrangedSubview(userErrorLabel)
        stackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordErrorLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(activityIndicator)
        
        activityIndicator.isHidden = true
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
    private func setupBindings() {
        viewModel.viewState.userName.bind = { [weak self] userName in
            guard let self = self else { return }
            self.userTextField.text = userName
        }
        
        viewModel.viewState.password.bind = { [weak self] password in
            guard let self = self else { return }
            self.passwordTextField.text = password
        }
        
        viewModel.viewState.userError.bind = { [weak self] userError in
            guard let self = self else { return }
            self.userErrorLabel.text = userError
            self.userErrorLabel.isHidden = userError == nil
        }
        
        viewModel.viewState.passwordError.bind = { [weak self] passwordError in
            guard let self = self else { return }
            self.passwordErrorLabel.text = passwordError
            self.passwordErrorLabel.isHidden = passwordError == nil
        }
        
        viewModel.viewState.isLoading.bind = { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            self.handleViewLoadingState(forLoading: isLoading)
        }
        
        viewModel.viewState.signInResult.bind = { [weak self] result in
            guard let self = self, let result = result else { return }
            self.userSignInResult.set(newValue: result)
        }
    }
    
    private func handleViewLoadingState(forLoading loading: Bool) {
        self.signInButton.isEnabled = !loading
        self.userTextField.isEnabled = !loading
        self.passwordTextField.isEnabled = !loading
        self.activityIndicator.isHidden = !loading
        loading
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
    }
    
    @objc
    private func onSignInButtonTapped() {
        endEditing(true)
        viewModel.dispatchInputAction(.didTapSignIn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 1 {
            viewModel.dispatchInputAction(.didUpdateUserName(userName: textField.text ?? ""))
        } else {
            viewModel.dispatchInputAction(.didUpdateUserPassword(password: textField.text ?? ""))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            viewModel.dispatchInputAction(.didEndEditingUser)
        } else {
            viewModel.dispatchInputAction(.didEndEditingPassword)
        }
    }
}

extension SignInView {
    enum SignInResult {
        case success
        case failed
    }
}
