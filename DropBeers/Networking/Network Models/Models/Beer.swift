//
//  Beer.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import Foundation

enum BrewType: String, Codable {
    case classic = "C"
    case barrelAged = "B"
    case undefined
}

struct Beer: Codable {
    var id: Int
    var brew: BrewType = .undefined

    init(id: Int, brew: BrewType) {
        self.id = id
        self.brew = brew
    }

    enum CodingKeys: String, CodingKey {
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
    }
}
