//
//  UIViewControllerExtensions.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/15/21.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
