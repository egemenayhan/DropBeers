//
//  BeerDetailRouter.swift
//  DropBeers
//
//  Created by Apple Seed on 6.09.2020.
//

import UIKit

protocol BeerDetailRoutable {
    func routeToBeerDetail(from context: UIViewController, beer: Beer)
}

extension BeerDetailRoutable {

    func routeToBeerDetail(from context: UIViewController, beer: Beer) {
        let detailVC = BeerDetailViewController.instantiate()
        detailVC.viewModel = BeerDetailViewModel(
            state: BeerDetailState(beer: beer),
            provider: BeerDataProvider()
        )
        context.navigationController?.pushViewController(detailVC, animated: true)
    }

}
