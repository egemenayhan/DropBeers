//
//  BeerDetailRouter.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit

protocol BeerDetailRoutable {
    func routeToBeerDetail(from context: BaseViewController, beer: Beer)
}

extension BeerDetailRoutable {

    func routeToBeerDetail(from context: BaseViewController, beer: Beer) {
        let detailVC = BeerDetailViewController.instantiate()
        detailVC.viewModel = BeerDetailViewModel(state: BeerDetailState(beer: beer))
        context.navigationController?.pushViewController(detailVC, animated: true)
    }

}
