//
//  BeerDetailViewModel.swift
//  DropBeers
//
//  Created by Apple Seed on 6.09.2020.
//

import Foundation

struct BeerDetailState {

    var beer: Beer

    enum Change {
        case loading
        case loaded
        case beerDetailFetched
        case error(message: String)
    }

}

class BeerDetailViewModel {

    typealias StateChangehandler = ((BeerDetailState.Change) -> Void)
    private var stateChangeHandler: StateChangehandler?
    private(set) var state: BeerDetailState
    private(set) var beerDataProvider: BeerDataProviding

    init(state: BeerDetailState, provider: BeerDataProviding) {
        self.state = state
        self.beerDataProvider = provider
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

    func fetchDetails() {
        stateChangeHandler?(.loading)
        beerDataProvider.fetchBeerDetail(id: state.beer.id) { [weak self] (result) in
            self?.stateChangeHandler?(.loaded)
            guard let strongSelf = self else { return }
            switch result {
            case .success(let beer):
                strongSelf.state.beer = beer
                strongSelf.stateChangeHandler?(.beerDetailFetched)
            case .failure(_):
                strongSelf.stateChangeHandler?(.error(message: "Error while fetching details!"))
            }
        }
    }

}
