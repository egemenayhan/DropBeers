//
//  BeerListViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import UIKit

class BeerListViewController: BaseViewController {

    private var viewModel = BeerListViewModel(state: BeerListState())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        viewModel.fetchCustomerInput()
    }

    private func configureViewModel() {
        // TODO: handle state changes
        viewModel.addChangeHandler { (change) in
            switch change {
            default:
                break
            }
        }
    }

}
