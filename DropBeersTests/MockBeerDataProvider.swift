//
//  MockBeerDataProvider.swift
//  DropBeersTests
//
//  Created by Egemen Ayhan on 10.09.2020.
//

import Foundation
@testable import DropBeers

struct MockBeerDataProvider: BeerDataProviding {

    var fileURL: URL?
    var beer: Beer?
    var beers: [Beer]?
    var error: NetworkingError?

    func fetchCustomerInput(from urlPath: String, completion: ((Result<URL, NetworkingError>) -> Void)?) {
        let result: Result<URL, NetworkingError>
        if let url = fileURL {
            result = .success(url)
        } else if let error = error {
            result = .failure(error)
        } else {
            result = .failure(.undefined)
        }
        completion?(result)
    }

    func fetchBeers(brewResult: BeerCalculator.BeerBrewResult, completion: ((Result<[Beer], NetworkingError>) -> Void)?) {
        let result: Result<[Beer], NetworkingError>
        if let beers = beers {
            result = .success(beers)
        } else if let error = error {
            result = .failure(error)
        } else {
            result = .failure(.undefined)
        }
        completion?(result)
    }

    func fetchBeerDetail(id: Int, completion: ((Result<Beer, NetworkingError>) -> Void)?) {
        let result: Result<Beer, NetworkingError>
        if let beer = beer {
            result = .success(beer)
        } else if let error = error {
            result = .failure(error)
        } else {
            result = .failure(.undefined)
        }
        completion?(result)
    }

}
