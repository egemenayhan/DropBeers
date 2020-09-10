//
//  BaseViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import UIKit

class BaseViewController: UIViewController, Instantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }

}
