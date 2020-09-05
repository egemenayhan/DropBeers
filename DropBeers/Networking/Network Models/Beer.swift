//
//  Beer.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import Foundation

enum BrewType: String {
    case classic = "C"
    case barrelAged = "B"
    case undefined
}

struct Beer {
    var type: Int
    var brew: BrewType
}
