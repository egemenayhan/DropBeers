//
//  BeerDetailViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit
import AlamofireImage

class BeerDetailViewController: BaseViewController {

    private enum Constants {
        static let rowHeight: CGFloat = 60.0
    }

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
    var stepPresentation = BeerStepPresentation()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Beer Details"
        updateUI()
        configureTableView()
        viewModel?.fetchDetails()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = Constants.rowHeight
        tableView.register(
            StepTableViewCell.nib,
            forCellReuseIdentifier: StepTableViewCell.reuseIdentifier
        )
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func configureViewModel() {
        viewModel?.addChangeHandler(handler: { [weak self] (change) in
            guard let strongSelf = self else { return }
            switch change {
            case .beerDetailFetched:
                if let beer = strongSelf.viewModel?.state.beer {
                    strongSelf.stepPresentation.update(with: beer)
                    strongSelf.tableView.reloadData()
                }
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

extension BeerDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return stepPresentation.steps.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepPresentation.presentations(for: section)?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StepTableViewCell.reuseIdentifier,
            for: indexPath
            ) as? StepTableViewCell else { return UITableViewCell() }
        let presentation = stepPresentation.presentations(for: indexPath.section)?[indexPath.row]
        cell.presentation = presentation
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(stepPresentation.steps.keys)[section].title
    }

}
