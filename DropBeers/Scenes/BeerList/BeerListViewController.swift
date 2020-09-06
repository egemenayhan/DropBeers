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

class BeerListViewController: BaseViewController {

    private enum Constants {
        static let tableViewHeight: CGFloat = 80.0
    }

    private var viewModel = BeerListViewModel(state: BeerListState())
    private var presentation = BeerListPresentation()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "DROP BEERS"
        configureViewModel()
        configureTableView()
        viewModel.fetchCustomerInput()
    }

    private func configureViewModel() {
        // TODO: handle state changes
        viewModel.addChangeHandler { [weak self] (change) in
            guard let strongSelf = self else { return }
            switch change {
            case .beersUpdated:
                strongSelf.presentation.update(with: strongSelf.viewModel.state.beers)
                strongSelf.tableView.reloadData()
            default:
                break
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
    // TODO: handle selection
}
