//
//  BeerDataProvider.swift
//  DropBeers
//
//  Created by Apple Seed on 10.09.2020.
//

import Foundation

struct BeerDataProvider: BeerDataProviding {

    func fetchCustomerInput(from urlPath: String, completion: ((Result<URL, NetworkingError>) -> Void)?) {
        NetworkManager.shared.downloadFile(from: urlPath) { (result) in
            completion?(result)
        }
    }

    func fetchBeers(brewResult: BeerCalculator.BeerBrewResult, completion: ((Result<[Beer], NetworkingError>) -> Void)?) {
        let request = BeerListRequest(results: brewResult)
        NetworkManager.shared.execute(request: request) { (response) in
            completion?(response.result)
        }
    }

    func fetchBeerDetail(id: Int, completion: ((Result<Beer, NetworkingError>) -> Void)?) {
        let request = BeerDetailRequest(beerId: id)
        NetworkManager.shared.execute(request: request) { (response) in
            let result: Result<Beer, NetworkingError>
            switch response.result {
            case .success(let beerResponse):
                if let beer = beerResponse.first {
                    result = .success(beer)
                } else {
                    result = .failure(.undefined)
                }
            case .failure(_):
                result = .failure(.undefined)
            }
            completion?(result)
        }
    }

}
