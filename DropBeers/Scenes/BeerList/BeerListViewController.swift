//
//  BeerListViewController.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import UIKit

struct BeerListPresentation {

    var presentations: [BeerCellPresentation] = []

    mutating func update(with beers: [Beer]) {
        presentations = beers.map {
            return BeerCellPresentation(
                name: $0.name,
                imagePath: $0.imagePath,
                abv: $0.abv,
                brewType: $0.brew
            )
        }
    }

}

class BeerListViewController: BaseViewController, BeerDetailRoutable {

    private enum Constants {
        static let tableViewHeight: CGFloat = 80.0
        static let loadingCornerRadius: CGFloat = 10.0
    }

    private var viewModel = BeerListViewModel(state: BeerListState())
    private var presentation = BeerListPresentation()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var loadingTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "DROP BEERS"
        configureViewModel()
        configureTableView()
        configureViews()
        viewModel.fetchCustomerInput()
    }

    private func configureViewModel() {
        // TODO: handle state changes
        viewModel.addChangeHandler { [weak self] (change) in
            guard let strongSelf = self else { return }
            switch change {
            case .loading(let title):
                strongSelf.loadingView.isHidden = false
                strongSelf.loadingTitleLabel.text = title ?? ""
            case .loaded:
                strongSelf.loadingView.isHidden = true
            case .beersUpdated:
                strongSelf.presentation.update(with: strongSelf.viewModel.state.beers)
                strongSelf.tableView.reloadData()
            case .error(let message):
                let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    strongSelf.dismiss(animated: true, completion: nil)
                }))
                strongSelf.present(alertController, animated: true, completion: nil)
            }
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Constants.tableViewHeight
        tableView.register(
            BeerTableViewCell.nib,
            forCellReuseIdentifier: BeerTableViewCell.reuseIdentifier
        )
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func configureViews() {
        loadingView.layer.cornerRadius = Constants.loadingCornerRadius
        loadingView.layer.masksToBounds = true
    }

}

// MARK: - UITableViewDataSource

extension BeerListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentation.presentations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BeerTableViewCell.reuseIdentifier,
            for: indexPath
            ) as? BeerTableViewCell else { return UITableViewCell() }

        cell.presentation = presentation.presentations[indexPath.row]
        return cell
    }

}

// MARK: - UITableViewDelegate

extension BeerListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routeToBeerDetail(from: self, beer: viewModel.state.beers[indexPath.row])
    }

}
