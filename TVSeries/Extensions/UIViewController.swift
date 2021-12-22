//
//  UIViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 04/06/20.
//

import UIKit
import SafariServices

extension UIViewController {
    func present(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "TVSeries", message: message, preferredStyle: .alert)
        alert.view.tintColor = .primaryColor
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentDecision(message: String, yes: ((UIAlertAction) -> Void)? = nil, no: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "TVSeries", message: message, preferredStyle: .alert)
        alert.view.tintColor = .primaryColor
        let action1 = UIAlertAction(title: "No", style: .destructive, handler: no)
        alert.addAction(action1)
        let action2 = UIAlertAction(title: "Yes", style: .default, handler: yes)
        alert.addAction(action2)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func present(error: Error) {
        present(message: error.localizedDescription)
    }
    
    func present(url: String) {
        guard let theUrl = URL(string: url) else {
            present(message: "Invalid URL")
            return
        }
        let safariVC = SFSafariViewController(url: theUrl)
        present(safariVC, animated: true, completion: nil)
    }
}
