//
//  BeerDataProviding.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 10.09.2020.
//

import Foundation

protocol BeerDataProviding {
    func fetchCustomerInput(from urlPath: String, completion: ((Result<URL,NetworkingError>) -> Void)?)
    func fetchBeers(brewResult: BeerCalculator.BeerBrewResult, completion: ((Result<[Beer], NetworkingError>) -> Void)?)
    func fetchBeerDetail(id: Int, completion: ((Result<Beer, NetworkingError>) -> Void)?)
}
