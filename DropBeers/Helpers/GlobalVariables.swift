//
//  GlobalVariables.swift
//  DropBeers
//
//  Created by Apple Seed on 5.09.2020.
//

enum Environment {
    case beta
    case prod
}

struct Global {

    // TODO: update according to build configuration
    private(set) static var environment: Environment = .beta

}
