//
//  UIAlertController+Extensions.swift
//  DropBeers
//
//  Created by Apple Seed on 10.09.2020.
//

import UIKit

extension UIAlertController {
    static func show(in context: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            context.dismiss(animated: true, completion: nil)
        }))
        context.present(alertController, animated: true, completion: nil)
    }
}
