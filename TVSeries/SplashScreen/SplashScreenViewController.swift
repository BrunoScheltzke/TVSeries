//
//  SplashScreen.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import UIKit

protocol SplashScreenViewControllerDelegate {
    func didAskToAuthenticate()
}

class SplashScreenViewController: UIViewController {
    var delegate: SplashScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAuthButton()
    }
    
    private func setupAuthButton() {
        let button = PrimaryRoundButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        button.setTitle("Authenticate", for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
    }
    
    @objc private func authButtonTapped() {
        delegate?.didAskToAuthenticate()
    }
}
