//
//  BeerListRequest.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import Alamofire

struct BeerListRequest: PunkAPIEndpoint {

    enum Constants {
        enum Parameters {
            static let idKey = "ids"
        }
    }

    typealias Response = [Beer]
    var path = "/v2/beers"
    var method: HTTPMethod = .get
    var parameters: [String : Any]

    init(results: BeerCalculator.BeerBrewResult) {
        let ids = results.keys.map { "\($0)" }.joined(separator: "|")
        parameters = [
            Constants.Parameters.idKey: ids,
        ]
    }
}
