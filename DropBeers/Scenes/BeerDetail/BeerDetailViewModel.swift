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
    }

}

class BeerDetailViewModel {

    typealias StateChangehandler = ((BeerDetailState.Change) -> Void)
    private var stateChangeHandler: StateChangehandler?
    let state: BeerDetailState

    init(state: BeerDetailState) {
        self.state = state
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

}
