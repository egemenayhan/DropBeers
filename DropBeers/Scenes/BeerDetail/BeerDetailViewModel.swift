//
//  BeerDetailViewModel.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
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

    init(state: BeerDetailState) {
        self.state = state
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

    func fetchDetails() {
        stateChangeHandler?(.loading)
        let request = BeerDetailRequest(beerId: state.beer.id)
        NetworkManager.shared.execute(request: request) { [weak self] (response) in
            self?.stateChangeHandler?(.loaded)
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let beerResponse):
                if let beer = beerResponse.first {
                    strongSelf.state.beer = beer
                    strongSelf.stateChangeHandler?(.beerDetailFetched)
                } else {
                    strongSelf.stateChangeHandler?(.error(message: "Detail response is not valid!"))
                }
            case .failure(_):
                strongSelf.stateChangeHandler?(.error(message: "Error while fetching details!"))
            }
        }
    }

}
