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

}
