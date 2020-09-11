//
//  BeerListViewModel.swift
//  DropBeers
//
//  Created by Apple Seed on 5.09.2020.
//

import  Foundation

struct BeerListState {

    private(set) var beers: [Beer] = []
    var brewResults: BeerCalculator.BeerBrewResult?

    enum Change {
        case loading(title: String? = nil)
        case loaded
        case beersUpdated
        case error(message: String)
    }

    mutating func updateBeers(with beers: [Beer]) {
        self.beers = beers
        self.beers.indices.forEach { (index) in
            if let brew = brewResults?[beers[index].id] {
                self.beers[index].brew = brew
            }
        }
    }

}

class BeerListViewModel {

    private enum Constants {
        static let inputPath = "https://gist.githubusercontent.com/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2/code_challenge_richer.txt"
    }

    typealias StateChangehandler = ((BeerListState.Change) -> Void)
    private var stateChangeHandler: StateChangehandler?
    private(set) var state: BeerListState
    private(set) var beerDataProvider: BeerDataProviding

    init(state: BeerListState, provider: BeerDataProviding) {
        self.state = state
        self.beerDataProvider = provider
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

    func fetchRequiredBeers() {
        stateChangeHandler?(.loading(title: "downloading input..."))
        beerDataProvider.fetchCustomerInput(from: Constants.inputPath) { [weak self] (result) in
            self?.stateChangeHandler?(.loaded)
            guard let strongSelf = self else { return }
            switch result {
            case .success(let url):
                strongSelf.calculateBeers(at: url)
            case .failure(_):
                strongSelf.stateChangeHandler?(.error(message: "Can not download customer input!"))
            }
        }
    }

    private func calculateBeers(at fileURL: URL) {
        let beerCalculator = BeerCalculator(with: fileURL)
        switch beerCalculator.calculate() {
        case .success(let results):
            state.brewResults = results
            fetchBeers()
        case .failure(let error):
            switch error {
            case .noSolution:
                stateChangeHandler?(.error(message: "No solution exist!"))
            case .fileError:
                stateChangeHandler?(.error(message: "Could`t read file!"))
            }
        }
    }

    private func fetchBeers() {
        guard let results = state.brewResults else { return }
        stateChangeHandler?(.loading(title: "getting beers..."))
        beerDataProvider.fetchBeers(brewResult: results) { [weak self] (result) in
            self?.stateChangeHandler?(.loaded)
            guard let strongSelf = self else { return }
            switch result {
            case .success(let beers):
                strongSelf.state.updateBeers(with: beers)
                strongSelf.stateChangeHandler?(.beersUpdated)
            case .failure(_):
                strongSelf.stateChangeHandler?(.error(message: "Couldn`t fetch beers!"))
            }
        }
    }

}
