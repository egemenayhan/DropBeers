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

    var title: String {
        switch self {
        case .classic:
            return "Classic"
        case .barrelAged:
            return "Barrel Aged"
        default:
            return "Undefined"
        }
    }
}

struct Beer: Codable {
    var id: Int
    var name: String?
    var imagePath: String?
    var abv: Double?
    var brew: BrewType = .undefined

    init(id: Int, brew: BrewType) {
        self.id = id
        self.brew = brew
    }

    enum CodingKeys: String, CodingKey {
        case id, abv, name
        case imagePath = "image_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.imagePath = try? container.decode(String.self, forKey: .imagePath)
        self.abv = try? container.decode(Double.self, forKey: .abv)
    }
}
