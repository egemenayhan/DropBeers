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
    var description: String?
    var imagePath: String?
    var abv: Double?
    var malts: [Ingredient]?
    var hops: [Ingredient]?
    var brew: BrewType = .undefined

    init(id: Int, brew: BrewType) {
        self.id = id
        self.brew = brew
    }

    enum CodingKeys: String, CodingKey {
        case id, abv, name, description, ingredients, malt, hops
        case imagePath = "image_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.imagePath = try? container.decode(String.self, forKey: .imagePath)
        self.abv = try? container.decode(Double.self, forKey: .abv)

        let subContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .ingredients)
        self.malts = try? subContainer?.decode([Ingredient].self, forKey: .malt)
        self.hops = try? subContainer?.decode([Ingredient].self, forKey: .hops)
    }

    func encode(to encoder: Encoder) throws {
        fatalError("Encode must be implemented!")
    }

}

struct Amount: Codable {
    let value: Double
    let unit: String
}

struct Ingredient: Codable {
    var name: String?
    var amount: Amount?
    var add: String?
    var attribute: String?
}
