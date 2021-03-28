//
//  DemoViewController.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import UIKit

class DemoViewController: UIViewController {
    private let viewModel: DemoViewModel
    private let signInView = SignInView()
    
    init(viewModel: DemoViewModel = DemoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBindings()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        signInView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInView)
        NSLayoutConstraint.activate([signInView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     signInView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
                                     signInView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                                     signInView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)])
        
    }
    
    private func setupViewBindings() {
        signInView.userSignInResult.bind = { [weak self] status in
            guard let self = self, let status = status else { return }
            switch status {
            case .success:
                self.viewModel.dispatchInputAction(.didSucceedSigningIn)
            case .failed:
                self.viewModel.dispatchInputAction(.didFailSigningIn)
            }
        }
    }
}
