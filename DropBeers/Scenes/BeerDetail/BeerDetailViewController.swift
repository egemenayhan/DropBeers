//
//  BeerDetailViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit

class BeerDetailViewController: BaseViewController {

    var viewModel: BeerDetailViewModel? {
        didSet {
            configureViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Beer Details"
    }

    private func configureViewModel() {
        viewModel?.addChangeHandler(handler: { (change) in
            switch change {
            default:
                break
            }
        })
    }

}
