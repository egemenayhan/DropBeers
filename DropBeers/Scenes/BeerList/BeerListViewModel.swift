//
//  BeerListViewModel.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import  Foundation

struct BeerListState {

    var beers: [Beer] = []

    enum Change {
        case loading
        case loaded
        case beersUpdated
        case error(message: String)
    }

}

class BeerListViewModel {

    private enum Constants {
        static let inputPath = "https://gist.githubusercontent.com/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2/code_challenge_richer.txt"
    }

    typealias StateChangehandler = ((BeerListState.Change) -> Void)
    private var stateChangeHandler: StateChangehandler?
    private(set) var state: BeerListState

    init(state: BeerListState) {
        self.state = state
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

    func fetchCustomerInput() {
        stateChangeHandler?(.loading)
        NetworkManager.shared.downloadFile(from: Constants.inputPath) { [weak self] (fileURL, error) in
            self?.stateChangeHandler?(.loaded)
            guard let strongSelf = self, let fileURL = fileURL else {
                self?.stateChangeHandler?(.error(message: error?.localizedDescription ?? "undefined"))
                return
            }
            strongSelf.calculateBeers(at: fileURL)
        }
    }

    private func calculateBeers(at fileURL: URL) {
        var beerCalculator = BeerCalculator(with: fileURL)
        switch beerCalculator.calculate() {
        case .success(let beers):
            state.beers = beers
            // TODO: fetch beer list
        case .failure(let error):
            switch error {
            case .noSolution:
                stateChangeHandler?(.error(message: "No solution exist!"))
            case .fileError:
                stateChangeHandler?(.error(message: "Could`t read file!"))
            }
        }
    }

}
