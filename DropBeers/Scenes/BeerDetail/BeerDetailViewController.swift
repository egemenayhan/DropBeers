//
//  BeerDetailViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit
import AlamofireImage

class BeerDetailViewController: BaseViewController {

    @IBOutlet private weak var beerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var abvLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: BeerDetailViewModel? {
        didSet {
            configureViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Beer Details"
        updateUI()
        viewModel?.fetchDetails()
    }

    private func configureViewModel() {
        viewModel?.addChangeHandler(handler: { [weak self] (change) in
            guard let strongSelf = self else { return }
            switch change {
            case .beerDetailFetched:
                strongSelf.updateUI()
            default:
                break
            }
        })
    }

    private func updateUI() {
        guard let beer = viewModel?.state.beer else { return }

        if let imageURL = URL(string: beer.imagePath ?? "") {
            beerImageView.af.setImage(withURL: imageURL)
        }
        nameLabel.text = beer.name
        abvLabel.text = "\(beer.abv ?? 0)"
        descriptionLabel.text = beer.description
    }

}
