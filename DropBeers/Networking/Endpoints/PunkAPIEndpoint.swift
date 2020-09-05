//
//  PunkAPIEndpoint.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

protocol PunkAPIEndpoint: Endpoint {}

extension PunkAPIEndpoint {

    func apiForEnvironment(_ environment: Environment) -> API {
        switch environment {
        case .beta:
            return API(baseURL: BaseURL(scheme: "https", host: "api.punkapi.com"))
        case .prod:
            return API(baseURL: BaseURL(scheme: "https", host: "api.punkapi.com"))
        }
    }
}
