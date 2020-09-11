//
//  BeerDetailRequest.swift
//  DropBeers
//
//  Created by Apple Seed on 6.09.2020.
//

import Alamofire

struct BeerDetailRequest: PunkAPIEndpoint {

    typealias Response = [Beer]
    var path = "/v2/beers"
    var method: HTTPMethod = .get

    init(beerId: Int) {
        path = path + "/\(beerId)"
    }

}
